#!/bin/sh
#Script configurazione interfacce di RETE per Proxmox PVE DASIT - Federico Dalè
#Config Porte ETH 1 e 3 in failover per la rete OSPEDALIERA in DHCP, Porte ETH 2 e 4 failover rete DASIT ip statico 192.168.2.19

#Download da GitHub del file interfaces, dove è presente la configurazione di Rete
curl -OL https://raw.githubusercontent.com/fededale95/DASITScript/main/interfaces

#Sposto il file nella cartella di sistema
mv interfaces /etc/network

#Riavvio le interfacce e il servizio di Rete
ifup -a
systemctl restart networking

#Mostro a schermo IP della macchina
echo "IP PROXMOX: "
hostname -I | awk '{print $1}'

#Riavvio
reboot
