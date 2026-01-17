# Docker Compose Files for BIND DNS

## Overview

This directory contains **non-default Docker Compose files** for running BIND DNS in various roles:

- Forwarding resolver
- Authoritative master
- Authoritative slave

These Compose files allow you to run fully functional containers without manually setting up networking or configuration. They are designed to:

- Expose port 53 for DNS (TCP/UDP)
- Demonstrate different DNS setups in isolation
- Provide educational examples for homelab or SMB IT use

All images assume the **local build name** `bind-dns`. You can also pull the published image from Docker Hub as `100781/bind-dns`.

## Usage Notes

1. **Configuration**  
   These Compose files assume you will **copy template configurations** into the appropriate paths (e.g., `/etc/bind`) and adjust as needed. The containers themselves will start with no preloaded zones if you do not mount configuration.

2. **Networking**  
   Each compose file maps DNS ports explicitly (53 TCP/UDP). Change these mappings if running multiple containers on the same host.

3. **Container Relationships**  
   - `docker-compose.master.yml` and `docker-compose.slave.yml` are meant to be run together for a full authoritative setup with redundancy.  
   - Running a slave is optional; the master can function alone. Consider operational risk when skipping the slave.

4. **Educational Context**  
   Each file represents a common DNS deployment pattern. Running them provides insight into:

   - How recursive resolvers differ from authoritative servers
   - How master-slave replication works
   - How DNS is isolated and managed in real networks

## Compose Files

### `docker-compose.resolver.yml`

- **Purpose:** Standalone recursive DNS resolver  
- **Behavior:**
  - Accepts recursive queries from all clients
  - Forwards unresolved queries to upstream (e.g., Quad9)  
- **Use Case:** Provides DNS resolution for internal networks or homelabs without hosting any authoritative zones

### `docker-compose.master.yml`

- **Purpose:** Authoritative DNS master server  
- **Behavior:**
  - Hosts both forward and reverse zones
  - Notifies configured slave servers on zone changes
  - No recursion enabled for security
- **Use Case:** Learn how to serve authoritative zones and manage zone files, including serial management

### `docker-compose.slave.yml`

- **Purpose:** Authoritative DNS slave server  
- **Behavior:**
  - Receives zone data from the master
  - Responds authoritatively for configured zones
  - No recursion
- **Use Case:** Understand DNS redundancy, zone transfer mechanics, and best practices for backup/resiliency

## Recommended Workflow

1. Start with the **resolver** to see how recursive queries behave
2. Deploy the **master** to serve zones locally
3. Optionally deploy the **slave** to learn about zone transfers and redundancy
4. Adjust template configs and zone files as you experiment

> These compose files provide a **safe, repeatable environment** to learn DNS principles without affecting your host network.

## Notes

- Always increment the **SOA serial** in master zone files before triggering a zone transfer
- Review port mappings and ACLs for production or network-facing environments
- These Compose files are intended for educational and homelab use; production deployments should include additional hardening

