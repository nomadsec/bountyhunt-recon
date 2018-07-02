#!/bin/bash
echo "-------> aquatone -> sublist3r -> merge -> tko-subs"
echo "-------> github/random-robbie for original script"
aquatone-discover -d $1 --threads 10
aquatone-scan -d $1 --ports huge --threads 10
DEBUG=nightmare xvfb-run -a aquatone-gather -d $1 --threads 10
aquatone-takeover -d $1 --threads 10
sublist3r -d $1 -v -b -o /root/results/$1/$1-subdomains.txt
dos2unix /root/results/$1/$1-subdomains.txt
cat /root/results/$1/$1-subdomains.txt /root/aquatone/$1/urls.txt >> /root/results/$1/$1-final.txt
sort /root/results/$1/$1-final.txt | uniq -u
/root/go/bin/tko-subs -domains=/root/results/$1/$1-final.txt -data=/root/providers-data.csv -output=/root/results/$1/tko-output.csv
python /root/tools/crlf_scan.py -i /root/results/$1/$1-final.txt -o /root/results/$1/crlf.txt
echo "-------> unicornscan ALL ports then nmap against open findings"
echo "-------> jexboss then content discovery with dirsearch"
/root/tools/onetwopunch/onetwopunch.sh -t /root/results/$1/$1-final.txt -n A,o /root/results/$1/$1-nmap-ports.txt
python root/tools/jexboss/jexboss.py -mode file-scan -file /root/results/$1/$1-final.txt -out /root/results/$1/$1-jboss.log
python root/tools/dirsearch/dirsearch.py /root/results/$1/$1-final.txt