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

if [ -d ~/recon/$DOM/Broken_Links ]
then
  echo " "
else
  mkdir ~/recon/$DOM/Broken_Links
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
echo "${blue} [+] Started Scanning for Broken Links ${reset}"
echo " "

#blc
if [ -f /usr/local/bin/blc ]
then
  echo "${magenta} [+] Running BLC for checking Broken links ${reset}"
  for domains in $(cat ~/recon/$DOM/Subdomains/all-alive-subs.txt);
  do
  blc $domains -ro > ~/recon/$DOM/Broken_Links/blc.txt && cat ~/recon/$DOM/Broken_Links/blc.txt | grep BROKEN > ~/recon/$DOM/Broken_Links/Broken_Links.txt
  done
else
  echo "${blue} [+] Installing BLC ${reset}"
  sudo apt-get install -y npm -qq > /dev/null
  sudo npm install broken-link-checker -g
  echo "${magenta} [+] Running BLC for checking Broken links${reset}"
  for domains in $(cat ~/recon/$DOM/Subdomains/all-alive-subs.txt);
  do
  blc $domains -ro > ~/recon/$DOM/Broken_Links/blc.txt && cat ~/recon/$DOM/Broken_Links/blc.txt | grep BROKEN > ~/recon/$DOM/Broken_Links/Broken_Links.txt
  done
fi

echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results ${reset}"
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
 
