# Split-Horizon DNS Configuration Template

## What This Template Is

This template configures BIND for **split-horizon DNS**, also known as **split-view DNS**.

It allows the same domain name to return **different answers depending on who is asking**.

This is not magic.
It is policy.

## When You Should Use This

Use this template when:

* Internal systems need private IPs
* External users should see public IPs
* You want one DNS server to serve multiple audiences
* You are learning how real-world DNS layouts work

If you’ve ever thought “the inside and outside should see different things,” this is the pattern.

## What This Template Is Not

This configuration does **not**:

* Perform load balancing
* Automatically sync zones between views
* Replace proper firewalling
* Make DNS security decisions for you

Split-horizon DNS is powerful, but it is also easy to misuse.

## Core Concept

Clients are matched into **views** based on source IP.

Each view:

* Has its own recursion behavior
* Has its own zone files
* Can return completely different answers for the same name

Same domain.
Different reality.

## Files in This Directory

### `named.conf`

Defines:

* Access control lists (ACLs)
* Views
* Zone ownership per view

Zone files are intentionally separate.

## Configuration Breakdown

### Internal Network ACL

```
acl internal {
    192.168.0.0/16;
};
```

This ACL defines who is considered “internal.”

Anything not matching this range is treated as external.

### Internal View

```
view "internal" {
    match-clients { internal; };
    recursion yes;

    zone "example.com" {
        type master;
        file "/etc/bind/zones/db.example.com.internal";
    };
};
```

Key behavior:

* Only internal clients match this view
* Recursive lookups are allowed
* The internal zone file is authoritative
* Internal-only records can safely exist here

This is where private IPs belong.

### External View

```
view "external" {
    match-clients { any; };
    recursion no;

    zone "example.com" {
        type master;
        file "/etc/bind/zones/db.example.com.external";
    };
};
```

Key behavior:

* Acts as the default catch-all
* Recursion is disabled
* Public-facing DNS only
* No leakage of internal addressing

This view should be boring and predictable.

## How View Matching Works

1. Client sends a DNS query
2. BIND checks views in order
3. First matching view wins
4. Only that view’s zones are visible

Views are not merged.
They are isolated.

## Important Design Rules

* Every view must fully define the zones it serves
* Records do not “fall through” between views
* Internal and external zone files must be maintained independently
* SOA serials are tracked per zone file

This is deliberate.
It prevents accidental exposure.

## Common Mistakes With Split-Horizon DNS

* Forgetting to include a record in both views
* Allowing recursion in the external view
* Using overlapping ACLs
* Treating views like conditional forwarders

If something “disappears,” check the view first.

## Why This Template Exists

Split-horizon DNS is everywhere:

* VPNs
* Corporate networks
* Hybrid cloud
* Zero-trust environments

Yet it’s often explained poorly or overcomplicated.

This template shows:

* The minimum required structure
* Clear separation of audiences
* Safe defaults
* Predictable behavior

DNS should be explicit.
Surprises are bugs.

## Final Thought

Split-horizon DNS is not about hiding things.
It’s about **context**.

Different clients need different truths.
DNS is simply enforcing that contract.
