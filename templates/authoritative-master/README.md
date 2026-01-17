# Authoritative Master

This template configures BIND as an authoritative **master** server.

Responsibilities:
- Hosts forward and reverse zones
- Acts as the source of truth
- Sends zone updates to slaves

Zone serial numbers **must be incremented** before slaves will transfer updates.
