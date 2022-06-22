#!/bin/sh
#Script configurazione interfacce di RETE per Proxmox PVE DASIT - Federico Dalè
#Config Porte ETH 1 e 3 in failover per la rete OSPEDALIERA in DHCP, Porte ETH 2 e 4 failover rete DASIT ip statico 192.168.2.19
echo "--- START ---"
echo ""
echo "Script Configurazione Network PVE DASIT - Federico Dale"
echo ""
curl -OL https://raw.githubusercontent.com/fededale95/DASITScript/main/interfaces
mv interfaces /etc/network
echo "--- Configurazione Rete OSPEDALIERA ---"
echo ""
echo "     ETH 1/3 failover  "
echo "     IP: DHCP"
echo ""
echo "---  End Config ---"
echo ""
echo "--- Configurazione Rete DASIT ---"
echo ""
echo "     ETH 2/4 failover  "
echo "     IP: STATIC        "
echo ""
echo "---  End Config ---"
echo ""
ifup -a
systemctl restart networking
echo "--- CONFIGURAZIONE TERMINATA ---"
echo "IP DASIT: "
hostname -I | awk '{print $2}'
echo "IP OSPEDALE: "
hostname -I | awk '{print $1}'
echo ""
echo "--- END ---"
