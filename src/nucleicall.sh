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

if [ -d ~/recon/$DOM/nuclei ]
then
  echo " "
else
  mkdir ~/recon/$DOM/nuclei
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
echo "${blue} [+] Started Nuclei Vulnerability Scanning ${reset}"
echo " "

#nuclei
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f ~/go/bin/nuclei ]
then
  echo "${magenta} [+] Running nuclei ${reset}"
  nuclei -update-templates
  nuclei -l ~/recon/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/cves/ -c 200 -o ~/recon/$DOM/nuclei/cves_results.txt
  nuclei -l ~/recon/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/files/ -c 200 -o ~/recon/$DOM/nuclei/files_results.txt
  nuclei -l ~/recon/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/vulnerabilities/ -c 200 -o ~/recon/$DOM/nuclei/vulnerabilities_results.txt
else
  echo "${blue} [+] Installing nuclei ${reset}"
  go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
  echo "${magenta} [+] Running nuclei ${reset}"
  nuclei -update-templates
  nuclei -l ~/recon/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/cves/ -c 200 -o ~/recon/$DOM/nuclei/cves_results.txt
  nuclei -l ~/recon/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/files/ -c 200 -o ~/recon/$DOM/nuclei/files_results.txt
  nuclei -l ~/recon/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/vulnerabilities/ -c 200 -o ~/recon/$DOM/nuclei/vulnerabilities_results.txt
fi

echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
 
