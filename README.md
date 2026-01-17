# BIND DNS Docker Templates for Homelabs and Learning
Welcome to the **BIND DNS Docker Templates** repository - a hands-on, educational resource for homelab enthusiasts and IT professionals who want to understand and experiment with DNS in a controlled environment.

These templates cover a progression from **vanilla installs** to **forwarding resolvers**, **authoritative masters and slaves**, and **split-horizon DNS**, giving you a realistic path for learning and experimentation.

## Who This Is For
- **Homelab enthusiasts**: Learn real-world DNS concepts safely in a lab environment.
- **MSP/IT professionals**: Apply concepts learned here to your networks, where contextually appropriate.
- **Students or hobbyists**: Understand authoritative, recursive, and split-horizon DNS in Docker.

This repository assumes **no prior production deployment**, but encourages experimenting with operational considerations and redundancy concepts.

## Usage Overview
1. **Vanilla Install**: Launch a container with no configuration - see how a clean BIND behaves.
2. **Forwarding Resolver**: Start a recursive resolver for internal clients only.
3. **Authoritative Master**: Manage zones for your domain(s), including forward and reverse lookups.
4. **Authoritative Slave**: Provide redundancy and load-sharing for authoritative zones.
5. **Split-Horizon DNS**: Serve different DNS answers based on client IPs (internal vs external).

> You can run multiple containers together, but a slave is optional. It’s a good practice for redundancy, but operational risk is your responsibility. Adjust configuration paths and ports as needed.

## Docker Images
- **Local build**: `docker build -t bind-dns .`
- **Published image**: `docker pull 100781/bind-dns`

All Compose files use explicit port mappings (default 53) and assume local testing; you may adjust as needed.

## Progression and Learning Path
1. **Vanilla** → Understand default BIND behavior.
2. **Forwarding Resolver** → Learn recursive resolution basics.
3. **Authoritative Master/Slave** → Dive into zone management and transfers.
4. **Split-Horizon DNS** → Explore client-based views and real-world network policies.

Each template’s `README.md` reinforces this progression with **practical context**, helping you learn safely while considering operational risk and redundancy.

## Goals
- Provide a **hands-on, reproducible lab** for DNS.
- Demonstrate **best practices** for authoritative, recursive, and split-horizon configurations.
- Give homelab enthusiasts and IT professionals **clear progression and context** for applying concepts.
- Encourage safe experimentation with Docker without affecting production networks.

## Next Steps
1. Browse the template directories to see each configuration and its corresponding `README.md`.
2. Experiment in Docker using the provided Compose files.
3. Adjust IPs, zone names, and ports for your environment.
4. Learn, iterate, and apply concepts where appropriate.

## Final Thoughts
DNS is simple in concept but subtle in practice.  
This repository provides **explanation, structure, and safe experimentation**, letting you learn the patterns behind real-world deployments - before making decisions that carry operational consequences.

(It's not _always_ DNS.)
