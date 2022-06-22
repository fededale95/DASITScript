#!/bin/sh
#Script configurazione interfacce di RETE per Proxmox PVE DASIT - Federico Dalè
#Config Porte ETH 1 e 3 in failover per la rete OSPEDALIERA in DHCP, Porte ETH 2 e 4 failover rete DASIT ip statico 192.168.2.19
echo "Script Configurazione Network PVE DASIT - Federico Dale"
echo ""
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
echo "     IP: 192.168.2.19"
echo ""
echo "---  End Config ---"
wget https://raw.githubusercontent.com/fededale95/DASITScript/main/interfaces
mv interfaces interfaces_test
mv interfaces_test /etc/network
#ifup -a
