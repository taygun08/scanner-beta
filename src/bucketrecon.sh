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

if [ -d ~/recon/$DOM/S3_Bucket_Recon ]
then
  echo " "
else
  mkdir ~/recon/$DOM/S3_Bucket_Recon

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
echo "${blue} [+] Started S3 Bucketrecon ${reset}"
echo " "

#screenshotting
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f ~/recon/tools/S3Scanner/s3scanner.py ]
then
  echo "${magenta} [+] Running S3Scanner for S3 Bucket Enumeration${reset}"
  python ~/recon/tools/S3Scanner/s3scanner.py ~/recon/$DOM/Subdomains/protoless-all-alive-subs.txt &> ~/recon/$DOM/S3_Bucket_Recon/s3_temp_result.txt
  cat ~/recon/$DOM/S3_Bucket_Recon/s3_temp_result.txt | grep "\[found\]" | cut -d" "  -f9- | tee -a ~/recon/$DOM/S3_Bucket_Recon/s3_result.txt
  rm -rf ~/recon/$DOM/S3_Bucket_Recon/s3_temp_result.txt
else
  echo "${blue} [+] Installing S3Scanner ${reset}"
  git clone https://github.com/sa7mon/S3Scanner ~/recon/tools/S3Scanner
  pip install -r ~/recon/tools/S3Scanner/requirements.txt
  echo "${magenta} [+] Running S3Scanner for S3 Bucket Enumeration${reset}"
  python ~/recon/tools/S3Scanner/s3scanner.py ~/recon/$DOM/Subdomains/protoless-all-alive-subs.txt &> ~/recon/$DOM/S3_Bucket_Recon/s3_temp_result.txt
  cat ~/recon/$DOM/S3_Bucket_Recon/s3_temp_result.txt | grep "\[found\]" | cut -d" "  -f9- | tee -a ~/recon/$DOM/S3_Bucket_Recon/s3_result.txt
  rm -rf ~/recon/$DOM/S3_Bucket_Recon/s3_temp_result.txt
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
