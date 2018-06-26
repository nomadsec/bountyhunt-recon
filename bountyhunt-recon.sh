#!/bin/bash

mkdir /root/results/%1


echo "[---] aquatone scan started - discover/scan/gather/takeover [---]"
aquatone-discover -d %1 --threads 10
aquatone-scan -d %1 --ports huge --threads 10
DEBUG=nightmare xvfb-run -a aquatone-gather -d %1 --threads 10
aquatone-takeover -d %1 --threads 10


echo "[---] sublist3r with bruteforce + merge w/ aquatone results [---]"
sublist3r -v -d -b $1 -o /root/results/%1/%1-subdomains.txt
dos2unix /root/results/%1/$1-subdomains.txt
cat /root/results/%1/$1-subdomains.txt /root/aquatone/$1/urls.txt >> /root/results/$1/$1-final.txt
sort /root/results/$1/$1-final.txt | uniq -u


echo "[---] TKO-SUBS hijacking check & CRLF URL injection check [---]"
/root/go/bin/tko-subs -domains=/root/results/$1/$1-final.txt -data=/root/providers-data.csv -output=/root/results/$1/tko-output.csv
python /root/tools/crlf_scan.py -i /root/results/%1/$1-final.txt -o /root/results/%1/crlf.txt


echo "[---] unicornscan ALL ports then nmap against open findings [---]"
echo "     ** remember to run NSE/aggressive nmap options on interesting finds!!"
/root/tools/onetwopunch/onetwopunch.sh -t /root/results/$1/$1-subdomains.txt -n A,o /root/results/$1/$1-nmap-ports.txt


echo "[---] jboss starting and content discovery with dirsearch [---]"
python root/tools/jexboss/jexboss.py -mode file-scan -file /root/results/$1/$1-final.txt -out /root/results/$1/$1-jboss.log
python root/tools/dirsearch/dirsearch.py /root/results/$1/$1-final.txt