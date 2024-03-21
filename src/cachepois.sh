#!/bin/bash


#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter domain name : " DOM

if [ -d ~/recon/$DOM/JScret ]
then
  echo " "
else
  mkdir -p ~/recon/$DOM/JScret
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
echo "${blue} [+] Started Scanning web cache poisining ${reset}"
echo " "



#scan web cache poisining
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Checking for dependencies ${reset}"
if [ -d ~/recon/tools/ForkCache ]
then
  echo "${magenta} [+] Already installed ForkCache ${reset}"
else
  echo "${blue} [+] Installing ForkCache ${reset}"
  git clone https://github.com/tismayil/fockcache.git ~/recon/tools/ForkCache
  cd ~/recon/tools/ForkCache; chmod +x install.sh; ./install.sh; cd -
fi
if [ -d ~/recon/$DOM/cachepois ] 
then
  echo ""
else
  mkdir -p ~/recon/$DOM/cachepois
fi

echo " "
echo "${blue} [+] Started web cache poisining ${reset}"
echo " "
if [ -f ~/recon/$DOM/Subdomains/all-alive-subs.txt ]
then
  for domains in $(cat ~/recon/$DOM/Subdomains/all-alive-subs.txt);
  do
  cd ~/recon/tools/ForkCache; ./ForkCache --hostname $domains
  done
else
  bash src/subenum.sh
  echo "${green}[+] test web cache poisining"
  for domains in $(cat ~/recon/$DOM/Subdomains/all-alive-subs.txt);
  do
  cd ~/recon/tools/ForkCache; ./ForkCache --hostname $domains
  done
fi

echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results${reset}"
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
 
