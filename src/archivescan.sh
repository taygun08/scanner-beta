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

if [ -d ~/recon/$DOM/Archivescan ]
then
  echo " "
else
  mkdir ~/recon/$DOM/Archivescan
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
echo "${blue} [+] Started Archive based Scanning ${reset}"
echo " "

#wayback_URL
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f ~/go/bin/waybackurls ]
then
 echo "${magenta} [+] Running Waybackurls for finding archive based assets${reset}"
 cat  ~/recon/$DOM/Subdomains/all-alive-subs.txt | waybackurls >> ~/recon/$DOM/Archivescan/waybackurls.txt 
else
 echo "${blue} [+] Installing Waybackurls ${reset}"
 go get -u github.com/tomnomnom/waybackurls
 echo "${blue} [+] Running Waybackurls for finding archive based assets${reset}"
 cat  ~/recon/$DOM/Subdomains/all-alive-subs.txt | waybackurls >> ~/recon/$DOM/Archivescan/waybackurls.txt 
fi
echo " "
echo "${blue} [+] Succesfully saved as waybackurls.txt ${reset}"
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "

#Gau
if [ -f ~/go/bin/gau ]
then
 echo "${magenta} [+] Running Gau for finding archive based assets${reset}"
 cat  ~/recon/$DOM/Subdomains/all-alive-subs.txt | gau  >> ~/recon/$DOM/Archivescan/gau.txt
else
 echo "${blue} [+] Installing Gaus ${reset}"
 go get -u github.com/lc/gau
 echo "${blue} [+] Running Gau for finding archive based assets${reset}"
 cat  ~/recon/$DOM/Subdomains/all-alive-subs.txt | gau >> ~/recon/$DOM/Archivescan/gau.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as gau.txt ${reset}"
echo " "

#uniquesubdomains
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] fetching unique URL ${reset}"
echo " "
cat ~/recon/$DOM/Archivescan/waybackurls.txt ~/recon/$DOM/Archivescan/gau.txt | sort -u >> ~/recon/$DOM/Archivescan/sorted.txt
echo "${blue} [+] Succesfully saved as sorted.txt ${reset}"
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
 
