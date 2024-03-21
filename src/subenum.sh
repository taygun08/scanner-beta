#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter the Domain name : " DOM

if [ -d ~/recon ]
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

if [ -d ~/recon/$DOM/Subdomains ]
then
  echo " "
else
  mkdir ~/recon/$DOM/Subdomains 
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
echo "${blue} [+] Started Subdomain Enumeration ${reset}"
echo " "

#assefinder
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f /usr/bin/assetfinder ]
then
  echo "${magenta} [+] Running Assetfinder for subdomain enumeration${reset}"
  assetfinder -subs-only $DOM  >> ~/recon/$DOM/Subdomains/assetfinder.txt 
else
  echo "${blue} [+] Installing Assetfinder ${reset}"
  sudo apt-get install assetfinder
  echo "${magenta} [+] Running Assetfinder for subdomain enumeration${reset}"
  assetfinder -subs-only $DOM  >> ~/recon/$DOM/Subdomains/assetfinder.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as assetfinder.txt  ${reset}"
echo " "

#amass
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f /usr/bin/amass ]
then
  echo "${magenta} [+] Running Amass for subdomain enumeration${reset}"
  amass enum --passive -d $DOM > ~/recon/$DOM/Subdomains/amass.txt
else
  echo "${blue} [+] Installing Amass ${reset}"
  echo "${blue} [+] This may take few minutes hang tight... ${reset}"
  sudo apt-get install amass
  echo "${magenta} [+] Running Amass for subdomain enumeration${reset}"
  amass enum --passive -d $DOM > ~/recon/$DOM/Subdomains/amass.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as amass.txt  ${reset}"
echo " "

#subfinder
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f /usr/bin/subfinder ]
then
  echo "${magenta} [+] Running Subfinder for subdomain enumeration${reset}"
  subfinder -d $DOM -o ~/recon/$DOM/Subdomains/subfinder.txt 
else
  echo "${blue} [+] Installing Subfinder ${reset}"
  sudo apt-get install subfinder 
  echo "${magenta} [+] Running Subfinder for subdomain enumeration${reset}"
  subfinder -d $DOM -o ~/recon/$DOM/Subdomains/subfinder.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as subfinder.txt  ${reset}"
echo " "

#find-domain
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f ~/go/bin/findomain-linux ]
then
  echo "${magenta} [+] Running Findomain for subdomain enumeration${reset}"
    findomain-linux --target $DOM -u ~/recon/$DOM/Subdomains/findomain.txt
else
  echo "${blue} [+] Installing Findomain ${reset}"
  wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux -P ~/go/bin/
  chmod +x ~/go/bin/findomain-linux
  echo "${magenta} [+] Running Findomain for subdomain enumeration${reset}"
  findomain-linux --target $DOM -u ~/recon/$DOM/Subdomains/findomain.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as findomain.txt  ${reset}"
echo " "

#uniquesubdomains
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${magenta} [+] Fetching unique domains ${reset}"
echo " "
cat ~/recon/$DOM/Subdomains/*.txt | sort -u >> ~/recon/$DOM/Subdomains/unique.txt
echo "${blue} [+] Succesfully saved as unique.txt ${reset}"
echo " "

#sorting alive subdomains
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f /usr/bin/httpx ]
then
  echo "${magenta} [+] Running Httpx for sorting alive subdomains${reset}"
  cat ~/recon/$DOM/Subdomains/unique.txt | httpx >> ~/recon/$DOM/Subdomains/all-alive-subs.txt
  cat ~/recon/$DOM/Subdomains/all-alive-subs.txt | sed 's/http\(.?*\)*:\/\///g' | sort -u > ~/recon/$DOM/Subdomains/protoless-all-alive-subs.txt
else
  echo "${blue} [+] Installing Httpx ${reset}"
  git clone https://github.com/projectdiscovery/httpx.git; cd httpx/cmd/httpx; go build; sudo mv httpx /usr/bin/; httpx -version
  echo "${magenta} [+] Running Httpx for sorting alive subdomains${reset}"
  cat ~/recon/$DOM/Subdomains/unique.txt | httpx >> ~/recon/$DOM/Subdomains/all-alive-subs.txt
  cat ~/recon/$DOM/Subdomains/all-alive-subs.txt | sed 's/http\(.?*\)*:\/\///g' | sort -u > ~/recon/$DOM/Subdomains/protoless-all-alive-subs.txt
fi
echo " "
echo "${blue} [+] Successfully saved the results"
echo " "

echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
 
