#!/bin/bash
echo "-------> aquatone -> sublist3r -> merge -> tko-subs"
echo "-------> github/random-robbie for original script"
mkdir /YOUR/PATH/targets/$1
touch /YOUR/PATH/targets/$1/$1-hosts.txt
amass enum -active -d $1 -o /YOUR/PATH/targets/$1/$1-hosts.txt 
cat /YOUR/PATH/targets/$1/$1-hosts.txt | aquatone -ports large -out /YOUR/PATH/targets/$1/aquatone
sublist3r -d $1 -v -b -o /YOUR/PATH/targets/$1/$1-subdomains.txt
dos2unix /YOUR/PATH/targets/$1/$1-subdomains.txt
cat /YOUR/PATH/targets/$1/$1-subdomains.txt /root/aquatone/$1/urls.txt >> /YOUR/PATH/targets/$1/$1-final.txt
sort /YOUR/PATH/targets/$1/$1-final.txt | uniq -u
go run /YOUR/PATH/tools/tko-subs/tko-subs.go -domains=/YOUR/PATH/targets/$1/$1-final.txt -data=/YOUR/PATH/tools/tko-subs/providers-data.csv -output=/YOUR/PATH/targets/$1/tko-output.csv
crlf scan -i /YOUR/PATH/targets/$1/$1-final.txt -o /YOUR/PATH/targets/$1/crlf.txt
echo "-------> unicornscan ALL ports then nmap against open findings"
echo "-------> jexboss then content discovery with dirsearch"
/YOUR/PATH/tools/onetwopunch/onetwopunch.sh -t /YOUR/PATH/targets/$1/$1-final.txt -n A,o /YOUR/PATH/targets/$1/$1-nmap-ports.txt
/YOUR/PATH/tools/jexboss/jexboss.py -mode file-scan -file /YOUR/PATH/targets/$1/$1-final.txt -out /YOUR/PATH/targets/$1/$1-jboss.log
/YOUR/PATH/tools/dirsearch/dirsearch.py /YOUR/PATH/targets/$1/$1-final.txt
