# Vanilla BIND Configuration Template

## What This Template Is

This template represents a **minimal, opinion-free BIND installation**.

It is intentionally sparse and exists to demonstrate:

* How BIND behaves with almost no configuration
* What BIND does *not* do unless explicitly told to
* A clean baseline for learning, testing, or building more advanced DNS roles

This configuration does **not** act as:

* An authoritative DNS server
* A recursive resolver
* A forwarding resolver

It answers queries only when explicitly allowed to and only with information it already has.

## When You Should Use This

Use this template when:

* You are learning how BIND behaves by default
* You want a known-clean starting point before layering functionality
* You are validating container behavior, file paths, or permissions
* You want to demonstrate that DNS does nothing “magical” out of the box

Do **not** use this template when:

* You expect name resolution to work beyond localhost tests
* You want recursive DNS for clients
* You want to host zones or accept zone transfers

This template is intentionally incomplete by design.

## Assumptions

This configuration assumes:

* You want to observe BIND’s default behavior, not solve DNS problems yet
* You are comfortable editing and extending configuration files later
* You understand that recursion, forwarding, and authority are *separate roles*

If you expect DNS resolution to work for clients using this config, something has already gone wrong conceptually.

## What This Template Intentionally Leaves Out

This configuration explicitly excludes:

* Authoritative zones
* Forwarders
* Recursion
* DNSSEC configuration
* Access control beyond basic query allowance
* IPv6 support
* Logging customization

These omissions are intentional and educational.

## Files in This Directory

### `named.conf`

This file acts as the top-level entry point for BIND configuration.

In this template, it does exactly one thing:

* Includes `named.conf.options`

No zones are declared.
No views are defined.
No behavior is layered in.

### `named.conf.options`

This file defines BIND’s runtime behavior.

Key behaviors configured here:

* **Listens on all IPv4 interfaces**
* **Disables IPv6**
* **Disables recursion**
* **Allows queries from any source**

This combination ensures:

* BIND will respond if queried
* BIND will not attempt to resolve anything it does not already know
* BIND will not forward queries upstream

## Operational Notes

* With `recursion no;`, BIND will return `REFUSED` or `NXDOMAIN` for most queries
* This is expected and correct behavior
* There are no zone files to edit because no zones exist
* Restarting BIND after changes is required, even if nothing “appears” to change

This template is not broken - it is deliberately empty.

## Common Mistakes

* Assuming BIND will resolve internet domains by default
* Expecting `dig google.com` to work
* Adding zone files without declaring them
* Using this template in production “just to start”

If DNS appears useless here, congratulations - that means it’s working as intended.

## How This Template Fits Into the Bigger Picture

This template is the foundation for all others in this repository.

Every advanced configuration:

* Authoritative master
* Authoritative slave
* Forwarding resolver
* Split-horizon DNS

…starts by *adding intent* to what is otherwise a passive service.

Understanding this template makes it clear that:

> DNS behavior is always a result of explicit decisions, not defaults.

## Next Steps

Choose a template that adds a specific role:

* **Authoritative Master** – when you own zones
* **Authoritative Slave** – when you want redundancy
* **Forwarding Resolver** – when clients need recursive DNS
* **Split-Horizon** – when different clients see different answers

Each template builds deliberately on what this one leaves out.

