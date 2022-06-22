#!/usr/bin/env bash -ex
#Script configurazione interfacce di RETE per Proxmox PVE DASIT - Federico Dalè
#Config Porte ETH 1 e 3 in failover per la rete OSPEDALIERA in DHCP, Porte ETH 2 e 4 failover rete DASIT ip statico 192.168.2.19
echo "--- START ---"
echo ""
echo -e "${RD}
 _____            _ _              _______      ________ 
|  __ \          (_) |            |  __ \ \    / /  ____|
| |  | | __ _ ___ _| |_   ______  | |__) \ \  / /| |__   
| |  | |/ _` / __| | __| |______| |  ___/ \ \/ / |  __|  
| |__| | (_| \__ \ | |_           | |      \  /  | |____ 
|_____/ \__,_|___/_|\__|          |_|       \/   |______|
                                                         
                                                         
 _   _      _                      _       _____             __ _       
| \ | |    | |                    | |     / ____|           / _(_)      
|  \| | ___| |___      _____  _ __| | __ | |     ___  _ __ | |_ _  __ _ 
| . ` |/ _ \ __\ \ /\ / / _ \| '__| |/ / | |    / _ \| '_ \|  _| |/ _` |
| |\  |  __/ |_ \ V  V / (_) | |  |   <  | |___| (_) | | | | | | | (_| |
|_| \_|\___|\__| \_/\_/ \___/|_|  |_|\_\  \_____\___/|_| |_|_| |_|\__, |
                                                                   __/ |
                                                                  |___/
${CL}"
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
echo ""
echo "IP DASIT: "
hostname -I | awk '{print $2}'
echo ""
echo "IP OSPEDALE: "
hostname -I | awk '{print $1}'
echo ""
echo "--- END ---"
