#!/bin/bash

#colors
red=`tput setaf 1`
#green=`tput setaf 2`
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

if [ -d ~/recon/$DOM/Visual_Recon ]
then
  echo " "
else
  mkdir ~/recon/$DOM/Visual_Recon

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
echo "${blue} [+] Starting Visual Recon ${reset}"
echo " "

#screenshotting
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f ~/go/bin/aquatone ]
then
  echo "${magenta} [+] Running Aquatone for screenshotting alive subdomains${reset}"
  cat ~/recon/$DOM/Subdomains/unique.txt | aquatone -http-timeout 10000 -scan-timeout 300 -ports xlarge -out ~/recon/$DOM/Visual_Recon
else
  echo "${blue} [+] Installing Aquatone ${reset}"
 go get github.com/michenriksen/aquatone
  echo "${magenta} [+] Running Aquatone for screenshotting alive subdomains${reset}"
  cat ~/recon/$DOM/Subdomains/unique.txt | aquatone -http-timeout 10000 -scan-timeout 300 -ports xlarge -out ~/recon/$DOM/Visual_Recon
fi

echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
