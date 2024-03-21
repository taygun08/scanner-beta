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

if [ -d ~/recon/$DOM/CORS_Scan ]
then
  echo " "
else
  mkdir ~/recon/$DOM/CORS_Scan

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
echo "${blue} [+] Started Scanning for CORS Misconfiguration${reset}"
echo " "

#corsy
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f ~/recon/tools/Corsy/corsy.py ]
then
  echo "${magenta} [+] Running cors scanner${reset}"
  python3 ~/recon/tools/Corsy/corsy.py -i ~/recon/$DOM/Subdomains/all-alive-subs.txt -t 25 -o ~/recon/$DOM/CORS_Scan/CORS_result.json
else
  echo "${blue} [+] Installing Corsy ${reset}"
  git clone https://github.com/s0md3v/Corsy ~/recon/tools/Corsy
  pip install -r ~/recon/tools/Corsy/requirements.txt
  echo "${magenta} [+] Running Cors scanner${reset}"
  python3 ~/recon/tools/Corsy/corsy.py -i ~/recon/$DOM/Subdomains/all-alive-subs.txt -t 25 -o ~/recon/$DOM/CORS_Scan/CORS_result.json
fi

echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo ""
echo "${red} [+] Thank you for using recon${reset}"
echo ""
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
