# BIND Configuration Templates

This directory contains **opinionated, progressively layered BIND configuration templates**.

Each template is designed to be:

* Runnable
* Readable
* Educational
* Focused on a single DNS role or pattern

They are intended to be explored **in order**, with each building naturally on concepts introduced in the previous one.

## How to Use These Templates

Each subdirectory contains:

* One or more BIND configuration files
* A dedicated `README.md` explaining *why* the configuration exists and *what problems it solves*

Start simple.
Move forward when the purpose of a template is clear.
DNS rewards patience and planning.

## Template Overview

### 1. Vanilla Resolver

**Purpose:**
Demonstrates a clean, minimal BIND installation with no opinions.

**What it teaches:**

* Core BIND structure
* Separation of `named.conf` and `named.conf.options`
* How little is required to run BIND safely

This is your baseline.
Everything else builds on this.

### 2. Forwarding DNS Resolver

**Purpose:**
Turns BIND into a recursive resolver that forwards queries upstream.

**What it teaches:**

* Recursion vs authority
* Forwarders and upstream trust
* Common homelab and edge-network use cases

This is how BIND often enters real networks.

### 3. Authoritative Master DNS

**Purpose:**
Hosts forward and reverse zones as the source of truth.

**What it teaches:**

* Zone definitions
* SOA records and serials
* Forward and reverse DNS
* Why authoritative DNS behaves differently than resolvers

This is where DNS becomes infrastructure.

### 4. Authoritative Slave DNS

**Purpose:**
Receives zone data from a master server and answers queries without owning the data.

**What it teaches:**

* Zone transfers
* Master vs slave responsibilities
* Redundancy without complexity
* Why secondary DNS matters

This is DNS growing up.

### 5. Split-Horizon DNS

**Purpose:**
Returns different answers for the same domain based on client source.

**What it teaches:**

* Views and ACLs
* Internal vs external DNS behavior
* Policy-driven resolution
* Real-world enterprise DNS patterns

This is DNS as intent enforcement.

## Design Philosophy

These templates intentionally avoid:

* Hidden automation
* Magic defaults
* Vendor abstractions

Everything is explicit.
Everything is inspectable.
Everything can be broken and fixed by reading the config.

That’s the point.

## Who This Is For

* Homelab enthusiasts who want to understand DNS properly
* MSP and SMB IT staff who touch DNS but don’t live in it
* Anyone tired of treating DNS as “that thing we don’t change”

DNS is foundational.
Understanding it pays dividends everywhere else.

## Final Note

If you only copy and paste these files, you will get working DNS.

If you read them, test them, and modify them, you’ll get something better:
confidence.

