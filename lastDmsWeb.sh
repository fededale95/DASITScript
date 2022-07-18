#!/bin/bash
ls -lt /share/CONSULENTI/DMSWEB | grep dmsweb-x64 >> vers.txt
cut vers.txt -c 67-72 >> lastVers1.txt
sed -n '1p' lastVers1.txt >> lastDMSWeb.txt
rm vers.txt
rm lastVers.txt
