#!/usr/bin/env bash -ex
set -euo pipefail
shopt -s inherit_errexit nullglob
YW=`echo "\033[33m"`
BL=`echo "\033[36m"`
RD=`echo "\033[01;31m"`
BGN=`echo "\033[4;92m"`
GN=`echo "\033[1;92m"`
DGN=`echo "\033[32m"`
CL=`echo "\033[m"`
BFR="\\r\\033[K"
HOLD="-"
CM="${GN}✓${CL}"
CROSS="${RD}✗${CL}"

if [ `pveversion | grep "pve-manager/7" | wc -l` -ne 1 ]; then
        echo -e "This script requires Proxmox Virtual Environment 7.0 or greater"
        echo -e "Exiting..."
        sleep 2
        exit
fi


function msg_info() {
    local msg="$1"
    echo -ne " ${HOLD} ${YW}${msg}..."
}

function msg_ok() {
    local msg="$1"
    echo -e "${BFR} ${CM} ${GN}${msg}${CL}"
}

clear

sleep 2
sed -i "s/^deb/#deb/g" /etc/apt/sources.list.d/pve-enterprise.list
msg_ok "Disabled Enterprise Repository"

cat <<EOF > /etc/apt/sources.list
deb http://ftp.debian.org/debian bullseye main contrib
deb http://ftp.debian.org/debian bullseye-updates main contrib
deb http://security.debian.org/debian-security bullseye-security main contrib
EOF
sleep 2
msg_ok "Added or Corrected PVE7 Sources"

cat <<EOF >> /etc/apt/sources.list
deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription
EOF
sleep 2
msg_ok "Enabled No-Subscription Repository"

cat <<EOF >> /etc/apt/sources.list
# deb http://download.proxmox.com/debian/pve bullseye pvetest
EOF
sleep 2
msg_ok "Added Beta/Test Repository"

echo "DPkg::Post-Invoke { \"dpkg -V proxmox-widget-toolkit | grep -q '/proxmoxlib\.js$'; if [ \$? -eq 1 ]; then { echo 'Removing subscription nag from UI...'; sed -i '/data.status/{s/\!//;s/Active/NoMoreNagging/}' /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js; }; fi\"; };" > /etc/apt/apt.conf.d/no-nag-script
apt --reinstall install proxmox-widget-toolkit &>/dev/null
msg_ok "Disabled Subscription Nag"

apt-get update &>/dev/null
apt-get -y dist-upgrade &>/dev/null
msg_ok "Updated Proxmox VE 7"

sleep 2
msg_ok "Finished Post Install Routines"
