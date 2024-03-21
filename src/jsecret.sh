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
echo "${blue} [+] Started Scanning for JS files ${reset}"
echo " "



#export js secrets
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Checking for dependencies ${reset}"
if [ -d ~/recon/tools/DumpsterDiver ]
then
  echo "${magenta} [+] Already installed DumpsterDiver ${reset}"
else
  echo "${blue} [+] Installing DumpsterDiver ${reset}"
  git clone https://github.com/securing/DumpsterDiver.git ~/recon/tools/DumpsterDiver
  pip3 install -r ~/recon/tools/DumpsterDiver/requirements.txt
fi
if [ -d ~/recon/$DOM/JSecret/files ]
then
  echo ""
else
  mkdir -p ~/recon/$DOM/JSecret/files
fi

echo " "
echo "${blue} [+] Started js files download ${reset}"
echo " "
if [ -f ~/recon/JScan/jsfiles_result.txt ]
then
  wget -P ~/recon/JSecret/files -i ~/recon/JScan/jsfiles_result.txt
  python3 ~/recon/tools/DumpsterDiver/DumpsterDiver.py -p ~/recon/JScan/files --level 3 -s -o ~/recon/JScan/secrets.json
else
  bash src/jsrecon.sh
  echo "${green}[+] Downloading js files"
  wget -P ~/recon/JSecret/files -i ~/recon/JScan/jsfiles_result.txt
  python3 ~/recon/tools/DumpsterDiver/DumpsterDiver.py -p ~/recon/JScan/files --level 3 -s -o ~/recon/JScan/secrets.json
fi

echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results${reset}"
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
 
