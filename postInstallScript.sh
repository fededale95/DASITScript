#!/bin/sh
export TERM=linux
if [ `pveversion | grep "pve-manager/7" | wc -l` -ne 1 ]; then
        echo -e "This script requires Proxmox Virtual Environment 7.0 or greater"
        echo -e "Exiting..."
        sleep 2
        exit
fi
      
clear

sleep 2
sed -i "s/^deb/#deb/g" /etc/apt/sources.list.d/pve-enterprise.list
echo "Disabled Enterprise Repository"

cat <<EOF > /etc/apt/sources.list
deb http://ftp.debian.org/debian bullseye main contrib
deb http://ftp.debian.org/debian bullseye-updates main contrib
deb http://security.debian.org/debian-security bullseye-security main contrib
EOF
sleep 2
echo "Added or Corrected PVE7 Sources"

cat <<EOF >> /etc/apt/sources.list
deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription
EOF
sleep 2
echo "Enabled No-Subscription Repository"

cat <<EOF >> /etc/apt/sources.list
# deb http://download.proxmox.com/debian/pve bullseye pvetest
EOF
sleep 2
echo "Added Beta/Test Repository"

echo "DPkg::Post-Invoke { \"dpkg -V proxmox-widget-toolkit | grep -q '/proxmoxlib\.js$'; if [ \$? -eq 1 ]; then { echo 'Removing subscription nag from UI...'; sed -i '/data.status/{s/\!//;s/Active/NoMoreNagging/}' /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js; }; fi\"; };" > /etc/apt/apt.conf.d/no-nag-script
apt --reinstall install proxmox-widget-toolkit &>/dev/null
echo "Disabled Subscription Nag"

apt-get update &>/dev/null
apt-get -y dist-upgrade &>/dev/null
echo "Updated Proxmox VE 7"

sleep 2
echo "Finished Post Install Routines"
