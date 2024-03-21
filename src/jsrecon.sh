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

if [ -d ~/recon/$DOM/JSscan ]
then
  echo " "
else
  mkdir ~/recon/$DOM/JSscan
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

#Gathering Js Files
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Checking for dependencies ${reset}"
if [ -f /usr/bin/httpx ]
then
  echo "${magenta} [+] Already installed httpx ${reset}"
else
  echo "${blue} [+] Installing httpx ${reset}"
  git clone https://github.com/projectdiscovery/httpx.git; cd httpx/cmd/httpx; go build; sudo mv httpx /usr/bin/; httpx -version
fi
if [ -f ~/go/bin/anew ]
then
  echo "${magenta} [+] Already installed anew ${reset}"
else
  echo "${blue} [+] Installing anew ${reset}"
  go get -u github.com/tomnomnom/anew
fi
if [ -f ~/go/bin/subjs ]
then
  echo "${magenta} [+] Already installed subjs ${reset}"
else
  echo "${blue} [+] Installing subjs ${reset}"
  go get -u github.com/lc/subjs
fi

echo " "
echo "${blue} [+] Started Gathering Live JsFiles-links ${reset}"
echo " "
cat ~/recon/$DOM/Archivescan/sorted.txt | grep -iE "\.js$" | uniq | sort >> ~/recon/$DOM/JSscan/mixed_jsfile_links_from_archives.txt
cat ~/recon/$DOM/JSscan/mixed_jsfile_links_from_archives.txt | httpx -silent >> ~/recon/$DOM/JSscan/jsfile_links_from_archives.txt
cat ~/recon/$DOM/Subdomains/all-alive-subs.txt | httpx -silent | subjs | anew | tee -a ~/recon/$DOM/JSscan/jsfile_links_from_subjs.txt
rm -rf ~/recon/$DOM/JSscan/mixed_jsfile_links_from_archives.txt
cat ~/recon/$DOM/JSscan/jsfile_links_from_archives.txt ~/recon/$DOM/JSscan/jsfile_links_from_subjs.txt | sort -u > ~/recon/JScan/jsfiles_result.txt

echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results${reset}"
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
 
