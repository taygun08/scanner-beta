#!/bin/bash


#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter domain name : " DOM

if [ -d ~/recon/ ]
then
  echo " "
else
  mkdir ~/recon
fi

if [ -d ~/recon/tools ]
then
  echo " "
else
  mkdir ~/recon/tools 
fi

if [ -d ~/recon/$DOM/Archivescan ]
then
  echo " "
else
  mkdir ~/recon/$DOM/Archivescan
fi

if [ -d ~/recon/$DOM/GF_Patterns ]
then
  echo " "
else
  mkdir ~/recon/$DOM/GF_Patterns
fi

echo "${red}
  ██████  ▄████▄   ▄▄▄       ███▄    █  ███▄    █ ▓█████  ██▀███  
▒██    ▒ ▒██▀ ▀█  ▒████▄     ██ ▀█   █  ██ ▀█   █ ▓█   ▀ ▓██ ▒ ██▒
░ ▓██▄   ▒▓█    ▄ ▒██  ▀█▄  ▓██  ▀█ ██▒▓██  ▀█ ██▒▒███   ▓██ ░▄█ ▒
  ▒   ██▒▒▓▓▄ ▄██▒░██▄▄▄▄██ ▓██▒  ▐▌██▒▓██▒  ▐▌██▒▒▓█  ▄ ▒██▀▀█▄  
▒██████▒▒▒ ▓███▀ ░ ▓█   ▓██▒▒██░   ▓██░▒██░   ▓██░░▒████▒░██▓ ▒██▒
▒ ▒▓▒ ▒ ░░ ░▒ ▒  ░ ▒▒   ▓▒█░░ ▒░   ▒ ▒ ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒▓ ░▒▓░
░ ░▒  ░ ░  ░  ▒     ▒   ▒▒ ░░ ░░   ░ ▒░░ ░░   ░ ▒░ ░ ░  ░  ░▒ ░ ▒░
░  ░  ░  ░          ░   ▒      ░   ░ ░    ░   ░ ░    ░     ░░   ░ 
      ░  ░ ░            ░  ░         ░          ░    ░  ░   ░     
         ░                                                        
${reset}"
echo "${blue} [+] Started GF Pattern based scans ${reset}"
echo " "

#wayback_URL
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f ~/go/bin/waybackurls ] 
then
 echo "${magenta} [+] Already installed Waybackurls ${reset}"
else
 echo "${blue} [+] Installing Waybackurls ${reset}"
 go get -u github.com/tomnomnom/waybackurls
fi
echo " "
if [ -f ~/recon/$DOM/Archivescan/waybackurls.txt ]
then
 echo "${magenta} [+] Already done Waybackurls ${reset}"
else
 echo "${blue} [+] Running Waybackurls for finding archive based assets${reset}"
 cat  ~/recon/$DOM/Subdomains/all-alive-subs.txt | waybackurls >> ~/recon/$DOM/Archivescan/waybackurls.txt 
 echo "${blue} [+] Succesfully saved as waybackurls.txt ${reset}"
fi
echo " "

#Gau
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f ~/go/bin/gau ]
then
 echo "${magenta} [+] Already installed Gau ${reset}"
else
 echo "${blue} [+] Installing Gau ${reset}"
 go get -u github.com/lc/gau
fi
echo " "
if [ -f ~/recon/$DOM/Archivescan/gau.txt ]
then
 echo "${magenta} [+] Already done Gau ${reset}"
else
 echo "${blue} [+] Running Gau for finding archive based assets${reset}"
 cat  ~/recon/$DOM/Subdomains/all-alive-subs.txt | gau >> ~/recon/$DOM/Archivescan/gau.txt
 echo "${blue} [+] Succesfully saved as gau.txt ${reset}"
fi
echo " "

#uniquesubdomains
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f ~/recon/$DOM/Archivescan/sorted.txt ]
then
 echo " "
else
 cat ~/recon/$DOM/Archivescan/waybackurls.txt ~/recon/$DOM/Archivescan/gau.txt | sort -u >> ~/recon/$DOM/Archivescan/sorted.txt
 echo "${blue} [+] Succesfully saved as sorted.txt ${reset}"
 echo " "
fi

#GFPattern
if [ -f ~/.gf/redirect.json ]
then
 echo "${magenta} [+] Running GF for pattern based scanning${reset}"
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf cors  >> ~/recon/$DOM/GF_Pattern/cors.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf aws-keys  >> ~/recon/$DOM/GF_Pattern/aws-keys.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf base64  >> ~/recon/$DOM/GF_Pattern/base64.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf s3-buckets >> ~/recon/$DOM/GF_Pattern/s3-buckets.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf idor | tee -a ~/recon/$DOM/GF_Patterns/idor.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf lfi | tee -a ~/recon/$DOM/GF_Patterns/lfi.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf rce | tee -a ~/recon/$DOM/GF_Patterns/rce.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf redirect | tee -a ~/recon/$DOM/GF_Patterns/redirect.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf sqli | tee -a ~/recon/$DOM/GF_Patterns/sqli.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf ssrf | tee -a ~/recon/$DOM/GF_Patterns/ssrf.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf ssti | tee -a ~/recon/$DOM/GF_Patterns/ssti.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf interestingparams | tee -a ~/recon/$DOM/GF_Patterns/interesting_parameters.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf interestingsubs | tee -a ~/recon/$DOM/GF_Patterns/interesting_subs.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf xss | tee -a ~/recon/$DOM/GF_Patterns/xss.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf interestingEXT | tee -a ~/recon/$DOM/GF_Patterns/interesting_extensions.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf debug_logic | tee -a ~/recon/$DOM/GF_Patterns/debug_logic.txt
else
 echo "${blue} [+] Installing GF_Patterns ${reset}"
 go get -u github.com/tomnomnom/gf
 git clone https://github.com/1ndianl33t/Gf-Patterns ~/recon/tools/Gf-Patterns
 mkdir ~/.gf
 mv ~/recon/tools/Gf-Patterns/*.json ~/.gf
 cp ~/go/src/github.com/tomnomnom/gf/examples/*.json ~/.gf
 echo "${blue} [+] Started GF for pattern based scanning${reset}"
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf cors | tee -a ~/recon/$DOM/GF_Patterns/cors.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf aws-keys | tee -a ~/recon/$DOM/GF_Patterns/aws-keys.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf base64 | tee -a ~/recon/$DOM/GF_Patterns/base64.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf s3-buckets | tee -a ~/recon/$DOM/GF_Patterns/s3-buckets.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf idor | tee -a ~/recon/$DOM/GF_Patterns/idor.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf lfi | tee -a ~/recon/$DOM/GF_Patterns/lfi.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf rce | tee -a ~/recon/$DOM/GF_Patterns/rce.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf redirect | tee -a ~/recon/$DOM/GF_Patterns/redirect.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf sqli | tee -a ~/recon/$DOM/GF_Patterns/sqli.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf ssrf | tee -a ~/recon/$DOM/GF_Patterns/ssrf.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf ssti | tee -a ~/recon/$DOM/GF_Patterns/ssti.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf interestingparams | tee -a ~/recon/$DOM/GF_Patterns/interesting_parameters.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf interestingsubs | tee -a ~/recon/$DOM/GF_Patterns/interesting_subs.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf xss | tee -a ~/recon/$DOM/GF_Patterns/xss.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf interestingEXT | tee -a ~/recon/$DOM/GF_Patterns/interesting_extensions.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf debug_logic | tee -a ~/recon/$DOM/GF_Patterns/debug_logic.txt
fi

echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results${reset}"
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
 
