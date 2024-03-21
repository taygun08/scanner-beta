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

if [ -d ~/recon/$DOM ]
then
  echo " "
else
  mkdir ~/recon/$DOM
fi

if [ -d ~/recon/$DOM/Subdomain_takeovers ]
then
  echo " "
else
  mkdir ~/recon/$DOM/Subdomain_takeovers
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
echo "${blue} [+] Started Subdomain Takeover and S3 Bucket Takeover Scanning ${reset}"
echo " "

#nuclei
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f ~/go/bin/nuclei ]
then
  echo "${magenta} [+] Running nuclei for finding potential takeovers${reset}"
  nuclei -update-templates
  nuclei -l ~/recon/$DOM/Subdomains/unique.txt -t ~/nuclei-templates/subdomain-takeover/ -o ~/recon/$DOM/Subdomain_takeovers/takeover_results.txt
else
  echo "${blue} [+] Installing nuclei ${reset}"
  go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
  echo "${magenta} [+] Running nuclei for finding potential takeovers${reset}"
  nuclei -update-templates
  nuclei -l ~/recon/$DOM/Subdomains/unique.txt -t ~/nuclei-templates/subdomain-takeover/ -o ~/recon/$DOM/Subdomain_takeovers/takeover_results.txt
fi

echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Successfully saved the results.txt"
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"