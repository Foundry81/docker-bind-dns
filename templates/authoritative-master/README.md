# Authoritative Master DNS Configuration Template

## What This Template Is

This template configures BIND as an **authoritative master DNS server**.

Its responsibilities are explicit:

* Host forward DNS zones
* Host reverse DNS zones
* Act as the source of truth for DNS data
* Provide zone data to clients (and potentially slaves)

This server **owns** the zones it serves.

## When You Should Use This

Use this template when:

* You control a domain and want to serve it yourself
* You need authoritative DNS for internal or private networks
* You are learning how DNS zones are structured and managed
* You plan to add slave servers later for redundancy

This is the foundation of proper DNS ownership.

## What This Template Is Not

This configuration does **not**:

* Perform recursive resolution
* Forward queries to upstream resolvers
* Act as a caching resolver
* Automatically notify slaves
* Restrict zone transfers or queries

It is intentionally minimal and instructional.

## Assumptions

This template assumes:

* Clients querying this server already know which domains it owns
* All authoritative zones are explicitly defined
* Zone files are stored and managed manually
* DNS recursion is handled elsewhere, if needed

This is a clean separation of authority and resolution.

## Files in This Directory

### `named.conf`

Defines the server role and declares authoritative zones.

### `zones/db.example.com`

Forward lookup zone for the `example.com` domain.

### `zones/db.192.168.100`

Reverse lookup zone for the `192.168.100.0/24` network.

## Configuration Breakdown

### Server Behavior

```
recursion no;
allow-query { any; };
```

* Recursion is disabled
* The server answers only for zones it owns
* Queries outside those zones will not be resolved

This enforces strict authoritative behavior.

### Forward Zone: example.com

```
zone "example.com" IN {
    type master;
    file "/etc/bind/zones/db.example.com";
};
```

This declares the server as the **master** for `example.com`.

All records for this domain live in the zone file and are authoritative.

### Reverse Zone: 192.168.100.0/24

```
zone "100.168.192.in-addr.arpa" IN {
    type master;
    file "/etc/bind/zones/db.192.168.100";
};
```

This enables reverse DNS lookups for the subnet.

Reverse zones are critical for:

* Logging
* Diagnostics
* Email servers
* Certificates and trust checks

## Forward Zone File Behavior

### Start of Authority (SOA)

```
2026010101 ; SERIAL - must be incremented for zone transfers
```

The serial number is critical.

Any change to the zone file requires:

* Incrementing the serial
* Reloading the zone

If the serial does not change, secondaries will not detect updates.

### Nameserver Records

```
IN NS ns1.example.com.
IN NS ns2.example.com.
```

These define which servers are authoritative for the domain.

Each nameserver must also have a corresponding A record.

### Common Record Types Used

* **A** – Maps a hostname to an IPv4 address
* **CNAME** – Creates an alias to another name
* **MX** – Defines mail delivery endpoints

This template intentionally uses common record types to reduce cognitive load.

## Reverse Zone File Behavior

### PTR Records

```
11  IN PTR ns1.example.com.
```

PTR records map IP addresses back to hostnames.

The number represents the final octet of the IP address within the subnet.

## What Happens at Runtime

* A client queries for a name within `example.com`
* BIND answers directly from its zone file
* No recursion or forwarding occurs
* Reverse lookups resolve based on PTR records

This server provides authoritative answers only.

## Common Mistakes When Learning DNS

* Forgetting to increment the SOA serial
* Expecting recursion to work
* Mixing resolver and authoritative roles
* Forgetting reverse zones exist

This template avoids those mistakes by design.

## Why This Template Exists

DNS is easiest to understand when roles are separated.

This template exists to demonstrate:

* Ownership of a domain
* Explicit zone declaration
* Manual control over DNS data
* Clear authoritative behavior

Everything else builds on top of this.

## Next Steps

Once comfortable with this template, you can explore:

* **Authoritative Slave** – redundancy and failover
* **Split-Horizon DNS** – internal vs external views
* **Resolver + Authority Separation** – production-grade layouts

Each adds complexity intentionally, not accidentally.
