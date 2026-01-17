# Authoritative Slave DNS Configuration Template

## What This Template Is

This template configures BIND as an **authoritative slave DNS server**.

Its role is narrow and intentional:

* Receive zone data from a master DNS server
* Answer authoritative queries using replicated data
* Provide redundancy and availability for DNS zones

This server **does not create or modify DNS data**.

## When You Should Use This

Use this template when:

* You want DNS redundancy for an authoritative zone
* You are learning how zone transfers work
* You want to separate “source of truth” from “availability”
* You are building toward production-style DNS layouts

Slave servers exist to make DNS boring and reliable.

## What This Template Is Not

This configuration does **not**:

* Host original zone data
* Allow local zone edits
* Perform recursion
* Forward queries to upstream resolvers
* Notify other servers of changes

All zone content comes from the master.

## Assumptions

This template assumes:

* A reachable and properly configured master DNS server exists
* Zone transfers from the master are permitted
* The slave should answer queries identically to the master
* Zone files are managed automatically by BIND

If the master goes away, the slave continues answering using its last copy.

## Files in This Directory

### `named.conf`

Defines the slave server behavior and identifies its masters.

Zone files are **not pre-created**. They are pulled automatically.

## Configuration Breakdown

### Server Behavior

```
recursion no;
allow-query { any; };
```

* The server answers authoritative queries only
* It does not resolve names outside the zones it serves
* This mirrors the behavior of the master

### Forward Zone: example.com

```
zone "example.com" IN {
    type slave;
    masters { 192.168.100.11; };
    file "db.example.com";
};
```

Key points:

* `type slave` tells BIND it does not own the zone
* `masters` defines where zone data is fetched from
* The zone file is created and maintained automatically

Manual edits to this file will be overwritten.

### Reverse Zone: 192.168.100.0/24

```
zone "100.168.192.in-addr.arpa" IN {
    type slave;
    masters { 192.168.100.11; };
    file "db.192.168.100";
};
```

Reverse zones behave exactly the same as forward zones:

* Data is pulled from the master
* Updates depend on the master’s SOA serial
* PTR records must be managed upstream

## How Zone Transfers Work

1. Slave starts or reloads
2. Slave contacts the master
3. SOA serial numbers are compared
4. Zone is transferred if the master serial is newer
5. Slave serves the updated data

If the serial does not change, no transfer occurs.

## What Happens at Runtime

* Client queries the slave
* Slave answers using its local copy of the zone
* No recursion or forwarding occurs
* Zone data remains static until updated by the master

From the client’s perspective, master and slave are indistinguishable.

## Common Mistakes When Learning Slaves

* Editing zone files locally on the slave
* Forgetting to increment the master’s SOA serial
* Expecting recursion to work
* Forgetting slaves need explicit permission to transfer zones

This template avoids those pitfalls by design.

## Why This Template Exists

Authoritative DNS is about ownership and resilience.

This template demonstrates:

* Clear separation of responsibility
* Automatic replication of DNS data
* How redundancy is achieved without complexity
* Why DNS scales so well when designed correctly

DNS should fail gracefully, not dramatically.

## Next Steps

Once comfortable with this template, you can explore:

* Multiple slaves across different networks
* Explicit transfer ACLs on the master
* Notify behavior and transfer tuning
* Split-horizon deployments with slaves

Each step builds directly on this foundation.
