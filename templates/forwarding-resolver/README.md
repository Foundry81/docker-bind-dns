# Forwarding DNS Resolver Configuration Template

## What This Template Is

This template configures BIND as a **pure forwarding recursive DNS resolver**.

Its role is simple and explicit:

* Accept recursive DNS queries from clients
* Forward all resolution requests to an upstream DNS provider
* Return the answers back to the client

This configuration does **not** host any zones and does **not** provide authoritative answers.

## When You Should Use This

Use this template when:

* You want BIND to act as a local recursive resolver
* You want centralized DNS resolution for clients
* You want to abstract or standardize upstream DNS providers
* You want caching behavior close to clients

This template is appropriate for:

* Homelab networks
* Small office environments
* Internal infrastructure DNS
* Testing recursive behavior without authority

## What This Template Is Not

This configuration does **not**:

* Serve authoritative zones
* Accept zone transfers
* Perform split-horizon DNS
* Restrict recursion to specific clients
* Perform DNSSEC policy tuning
* Act as a secondary or slave server

It does one job and does it clearly.

## Assumptions

This template assumes:

* Clients explicitly point to this server for DNS
* An upstream resolver exists and is reachable
* You are comfortable with open recursion during learning or testing

If this is used in a production environment, access controls should be considered separately.

## Files in This Directory

### `named.conf`

This is the only configuration file used in this template.

All behavior is defined directly within it, without includes or external dependencies.

## Behavior Breakdown

### Recursive Resolution

```
recursion yes;
allow-recursion { any; };
```

* Enables recursive DNS resolution
* Allows any client to request recursion
* Suitable for controlled environments and learning scenarios

### Forwarding Behavior

```
forwarders {
    9.9.9.9; // Quad9 - replace with the resolver(s) of your choice
};
```

* All queries are forwarded upstream
* This server does not attempt iterative resolution
* Upstream provider is responsible for DNSSEC and recursion logic

The resolver acts as a smart relay with caching.

### Network Behavior

```
listen-on { any; };
listen-on-v6 { none; };
```

* Listens on all IPv4 interfaces
* IPv6 is intentionally disabled for clarity and simplicity


## What Happens at Runtime

* A client sends a DNS query
* BIND checks its local cache
* If no cached answer exists, the query is forwarded upstream
* The response is cached and returned
* Subsequent queries are answered faster

This is classic forwarding-resolver behavior.


## Common Misunderstandings

* This server is **not authoritative** for any domain
* You cannot add zone files and expect them to work
* PTR or internal domains will not resolve unless upstream knows them
* This template does not magically “own” DNS

It resolves. It does not decide.


## Why This Template Exists

This template exists to clearly separate:

* **Resolution** from **authority**
* **Convenience** from **ownership**
* **Learning DNS behavior** from **running production DNS**

Many DNS problems stem from mixing these roles unintentionally.

This template makes the role explicit.


## Next Steps

From here, you can move to:

* **Authoritative Master** – when you want to own a domain
* **Authoritative Slave** – when you need redundancy
* **Split-Horizon DNS** – when different clients need different answers

Each adds complexity intentionally on top of this clear baseline.
