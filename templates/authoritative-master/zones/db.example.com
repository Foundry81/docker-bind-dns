$ORIGIN example.com.
$TTL 86400

@   IN  SOA ns1.example.com. admin.example.com. (
        2026010101 ; SERIAL - must be incremented for zone transfers
        28800
        7200
        604800
        86400 )

    IN  NS  ns1.example.com.
    IN  NS  ns2.example.com.

ns1 IN  A   192.168.100.11
ns2 IN  A   192.168.100.12

@   IN  A   192.168.100.20
www IN  CNAME example.com.
mail IN A   192.168.100.25

@   IN  MX  10 mail.example.com.
