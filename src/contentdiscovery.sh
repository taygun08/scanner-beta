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
 
if [ -d ~/recon/tools ]
then
  echo " "
else
  mkdir ~/recon/tools 
fi

if [ -d ~/recon/$DOM/Content_Discovery ]
then
  echo " "
else
  mkdir ~/recon/$DOM/Content_Discovery
 
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
echo "${blue} [+] Started Content Discovery Scanning ${reset}"
echo " "

#wordlist
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f ~/recon/tools/common.txt ]
then
 echo " "
else
 echo "${blue} [+] Downloading wordlists ${reset}"
 wget https://raw.githubusercontent.com/v0re/dirb/master/wordlists/common.txt -P ~/recon/tools/
fi

#feroxbuster
if [ -f ~/go/bin/feroxbuster ]
then
 echo "${magenta} [+] Running Feroxbuster for content discovery${reset}"
 for url in $(cat ~/recon/$DOM/Subdomains/all-alive-subs.txt);do
 reg=$(echo $url | sed -e 's;https\?://;;' | sed -e 's;/.*$;;')
 feroxbuster --url $reg -w ~/recon/tools/common.txt -x php asp aspx jsp py txt conf config bak backup swp old db zip sql --depth 3 --threads 300 --output ~/recon/$DOM/Content_Discovery/content_discovery_result.txt
done
else
 echo "${blue} [+] Installing Feroxbuster ${reset}"
 wget https://github.com/epi052/feroxbuster/releases/download/v1.5.2/x86_64-linux-feroxbuster.zip -P ~/recon/tools/feroxbuster
 unzip ~/recon/tools/feroxbuster/x86_64-linux-feroxbuster.zip -d ~/go/bin/
 chmod 777 ~/go/bin/feroxbuster
 echo "${magenta} [+] Running Feroxbuster for content discovery${reset}"
 for url in $(cat ~/recon/$DOM/Subdomains/all-alive-subs.txt);do
 reg=$(echo $url | sed -e 's;https\?://;;' | sed -e 's;/.*$;;')
 feroxbuster --url $reg -w ~/recon/tools/common.txt -x php asp aspx jsp py txt conf config bak backup swp old db zip sql --depth 3 --threads 300 --output ~/recon/$DOM/Content_Discovery/content_discovery_result.txt
done
fi

echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Succesfully saved as content_discovery_result.txt ${reset}"
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${magenta} [+] Sorting According to Status Codes ${reset}"
cat ~/recon/$DOM/Content_Discovery/content_discovery_result.txt | grep 200 | awk '{print $2}' > ~/recon/$DOM/Content_Discovery/status_code_200.txt  
cat ~/recon/$DOM/Content_Discovery/content_discovery_result.txt | grep 204 | awk '{print $2}' > ~/recon/$DOM/Content_Discovery/status_code_204.txt
cat ~/recon/$DOM/Content_Discovery/content_discovery_result.txt | grep 301 | awk '{print $2}' > ~/recon/$DOM/Content_Discovery/status_code_301.txt
cat ~/recon/$DOM/Content_Discovery/content_discovery_result.txt | grep 302 | awk '{print $2}' > ~/recon/$DOM/Content_Discovery/status_code_302.txt
cat ~/recon/$DOM/Content_Discovery/content_discovery_result.txt | grep 307 | awk '{print $2}' > ~/recon/$DOM/Content_Discovery/status_code_307.txt
cat ~/recon/$DOM/Content_Discovery/content_discovery_result.txt | grep 308 | awk '{print $2}' > ~/recon/$DOM/Content_Discovery/status_code_308.txt
cat ~/recon/$DOM/Content_Discovery/content_discovery_result.txt | grep 401 | awk '{print $2}' > ~/recon/$DOM/Content_Discovery/status_code_401.txt
cat ~/recon/$DOM/Content_Discovery/content_discovery_result.txt | grep 403 | awk '{print $2}' > ~/recon/$DOM/Content_Discovery/status_code_403.txt
cat ~/recon/$DOM/Content_Discovery/content_discovery_result.txt | grep 405 | awk '{print $2}' > ~/recon/$DOM/Content_Discovery/status_code_405.txt
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results according to their status codes ${reset}"
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
 

