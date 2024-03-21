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

if [ -d ~/recon/$DOM ]
then
  echo " "
else
  mkdir ~/recon/$DOM
fi

if [ -d ~/recon/$DOM/Param_mining ]
then
  echo " "
else
  mkdir ~/recon/$DOM/Param_mining
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
echo "${blue} [+] Started Param Mining ${reset}"
echo " "
#ParamSpider
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -d ~/recon/tools/ParamSpider/ ]
then
  echo "${magenta} [+] Running ParamSpider for mining endpoints${reset}"
  for url in $(cat ~/recon/$DOM/Subdomains/all-alive-subs.txt);do
  python3 ~/recon/tools/ParamSpider/paramspider.py -d $url -o ~/recon/$DOM/Param_mining/$url.txt
  done
else
  echo "${blue} [+] Installing ParamSpider ${reset}"
  git clone https://github.com/devanshbatham/ParamSpider ~/recon/tools/ParamSpider/
  echo "${magenta} [+] Running ParamSpider for mining endpoints${reset}"
  for url in $(cat ~/recon/$DOM/Subdomains/all-alive-subs.txt);do
  python3 ~/recon/tools/ParamSpider/paramspider.py -d $url -o ~/recon/$DOM/Param_mining/$url.txt
  done
fi
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results  ${reset}"
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
 
