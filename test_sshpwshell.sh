#!/bin/sh
curl -OL https://raw.githubusercontent.com/fededale95/DASITScript/main/interfaces
cp /root/test.sh /root/test_copia.sh
hostname -I | awk '{print $2}'
