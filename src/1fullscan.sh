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
if [ -d ~/recon/$DOM/Subdomain_takeovers ]
then
  echo " "
else
  mkdir ~/recon/$DOM/Subdomain_takeovers
fi
if [ -d ~/recon/$DOM/nuclei ]
then
  echo " "
else
  mkdir ~/recon/$DOM/nuclei
fi
if [ -d ~/recon/$DOM/Broken_Links ]
then
  echo " "
else
  mkdir ~/recon/$DOM/Broken_Links
fi
if [ -d ~/recon/$DOM/Port_Scan ]
then
  echo " "
else
  mkdir ~/recon/$DOM/Port_Scan
fi
if [ -d ~/recon/$DOM/Archivescan ]
then
  echo " "
else
  mkdir ~/recon/$DOM/Archivescan
fi
if [ -d ~/recon/$DOM/GF_Patterns ]
then
  echo " "
else
  mkdir ~/recon/$DOM/GF_Patterns
fi
if [ -d ~/recon/$DOM/JSscan ]
then
  echo " "
else
  mkdir ~/recon/$DOM/JSscan
fi
if [ -d ~/recon/$DOM/S3_Bucket_Recon ]
then
  echo " "
else
  mkdir ~/recon/$DOM/S3_Bucket_Recon
fi
if [ -d ~/recon/$DOM/CORS_Scan ]
then
  echo " "
else
  mkdir ~/recon/$DOM/CORS_Scan
fi
if [ -d ~/recon/$DOM/Param_mining ]
then
  echo " "
else
  mkdir ~/recon/$DOM/Param_mining
fi
if [ -d ~/recon/$DOM/Content_Discovery ]
then
  echo " "
else
  mkdir ~/recon/$DOM/Content_Discovery 
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
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Successfully saved the results.txt"
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
#nuclei
echo " "
if [ -f ~/go/bin/nuclei ]
then
  echo "${magenta} [+] Running nuclei for finding potential takeovers${reset}"
  nuclei -update-templates
  nuclei -l ~/recon/$DOM/Subdomains/unique.txt -t ~/nuclei-templates/subdomain-takeover/ -o ~/recon/$DOM/Subdomain_takeovers/takeover_results.txt
else
  echo "${blue} [+] Installing nuclei ${reset}"
  go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
  echo "${magenta} [+] Running nuclei for finding potential takeovers${reset}"
  nuclei -update-templates
  nuclei -l ~/recon/$DOM/Subdomains/unique.txt -t ~/nuclei-templates/subdomain-takeover/ -o ~/recon/$DOM/Subdomain_takeovers/takeover_results.txt
fi
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Successfully saved the results.txt"
echo " "
#nuclei
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f ~/go/bin/nuclei ]
then
  echo "${magenta} [+] Running nuclei ${reset}"
  nuclei -update-templates
  nuclei -l ~/recon/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/cves/ -c 200 -o ~/recon/$DOM/nuclei/cves_results.txt
  nuclei -l ~/recon/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/files/ -c 200 -o ~/recon/$DOM/nuclei/files_results.txt
  nuclei -l ~/recon/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/vulnerabilities/ -c 200 -o ~/recon/$DOM/nuclei/vulnerabilities_results.txt
else
  echo "${blue} [+] Installing nuclei ${reset}"
  go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
  echo "${magenta} [+] Running nuclei ${reset}"
  nuclei -update-templates
  nuclei -l ~/recon/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/cves/ -c 200 -o ~/recon/$DOM/nuclei/cves_results.txt
  nuclei -l ~/recon/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/files/ -c 200 -o ~/recon/$DOM/nuclei/files_results.txt
  nuclei -l ~/recon/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/vulnerabilities/ -c 200 -o ~/recon/$DOM/nuclei/vulnerabilities_results.txt
fi
echo ""
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
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
#blc
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
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
#dnsx
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f ~/go/bin/dnsx ]
then
 echo "${magenta} [+] Running dnsprobe for resolving IP's${reset}"
 dnsx -l ~/recon/$DOM/Subdomains/unique.txt -resp-only | sort -u > ~/recon/$DOM/Port_Scan/resolved_ips.txt
else
 echo "${magenta} [+] Installing dnsprobe ${reset}"
 go get -u -v github.com/projectdiscovery/dnsx/cmd/dnsx
 echo "${magenta} [+] Running dnsprobe for resolving IP's${reset}"
 dnsx -l ~/recon/$DOM/Subdomains/unique.txt -resp-only | sort -u > ~/recon/$DOM/Port_Scan/resolved_ips.txt
fi
#grepcidr
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ ! -x "$(command -v grepcidr)" ]; then
	echo "${blue} [+] Installing grepcidr ${reset}"
	yay -S grepcidr
	echo " "
else
	echo "${blue} [+] grepcidr is already installed ${reset}"
fi
#Removing IP behind Cloudflare
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${magenta} [+] Running grepcidr for removing hosts behind WAF${reset}"
cloudflare="173.245.48.0/20 103.21.244.0/22 103.22.200.0/22 103.31.4.0/22 141.101.64.0/18 108.162.192.0/18 190.93.240.0/20 188.114.96.0/20 197.234.240.0/22 198.41.128.0/17 162.158.0.0/15 104.16.0.0/12 172.64.0.0/13 131.0.72.0/22"
for ip in $(cat ~/recon/$DOM/Port_Scan/resolved_ips.txt); do
echo $ip | grepcidr "$cloudflare" >/dev/null && echo "${red} [!] $ip is protected by Cloudflare ${reset}" || echo "$ip" >> ~/recon/$DOM/Port_Scan/afterremovecloudflare.txt
done
#Removing IP behind Incapsula
incapsula="199.83.128.0/21 198.143.32.0/19 149.126.72.0/21 103.28.248.0/22 45.64.64.0/22 185.11.124.0/22 192.230.64.0/18 107.154.0.0/16 45.60.0.0/16 45.223.0.0/16"
for ip in $(cat ~/recon/$DOM/Port_Scan/afterremovecloudflare.txt); do
echo $ip | grepcidr "$incapsula" >/dev/null && echo "${red} [!] $ip is protected by Incapsula ${reset}" || echo "$ip" >> ~/recon/$DOM/Port_Scan/afterremoveincapsula.txt
done
#Removing IP behind Sucuri
sucuri="185.93.228.0/24 185.93.229.0/24 185.93.230.0/24 185.93.231.0/24 192.124.249.0/24 192.161.0.0/24 192.88.134.0/24 192.88.135.0/24 193.19.224.0/24 193.19.225.0/24 66.248.200.0/24 66.248.201.0/24 66.248.202.0/24 66.248.203.0/24"
for ip in $(cat ~/recon/$DOM/Port_Scan/afterremoveincapsula.txt); do
echo $ip | grepcidr "$sucuri" >/dev/null && echo "${red} [!] $ip is protected by Sucuri ${reset}" || echo "$ip" >> ~/recon/$DOM/Port_Scan/afterremovesucuri.txt
done
#Removing IP behind Akamai
akamai="104.101.221.0/24 184.51.125.0/24 184.51.154.0/24 184.51.157.0/24 184.51.33.0/24 2.16.36.0/24 2.16.37.0/24 2.22.226.0/24 2.22.227.0/24 2.22.60.0/24 23.15.12.0/24 23.15.13.0/24 23.209.105.0/24 23.62.225.0/24 23.74.29.0/24 23.79.224.0/24 23.79.225.0/24 23.79.226.0/24 23.79.227.0/24 23.79.229.0/24 23.79.230.0/24 23.79.231.0/24 23.79.232.0/24 23.79.233.0/24 23.79.235.0/24 23.79.237.0/24 23.79.238.0/24 23.79.239.0/24 63.208.195.0/24 72.246.0.0/24 72.246.1.0/24 72.246.116.0/24 72.246.199.0/24 72.246.2.0/24 72.247.150.0/24 72.247.151.0/24 72.247.216.0/24 72.247.44.0/24 72.247.45.0/24 80.67.64.0/24 80.67.65.0/24 80.67.70.0/24 80.67.73.0/24 88.221.208.0/24 88.221.209.0/24 96.6.114.0/24"
for ip in $(cat ~/recon/$DOM/Port_Scan/afterremovesucuri.txt); do
echo $ip | grepcidr "$akamai" >/dev/null && echo "${red} [!] $ip is protected by Akamai ${reset}" || echo "$ip" >> ~/recon/$DOM/Port_Scan/Final_IP_List.txt
done
#Removing Unnecassery files
rm -rf ~/recon/$DOM/Port_Scan/afterremovecloudflare.txt ~/recon/$DOM/Port_Scan/afterremoveincapsula.txt ~/recon/$DOM/Port_Scan/afterremovesucuri.txt
#rust scan
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${magenta} [+] Updating and running Rust Scan for scanning ports${reset}"
systemctl start docker.socket
for url in $(cat ~/recon/$DOM/Port_Scan/Final_IP_List.txt);do
sudo docker run -it --rm --name rustscan rustscan/rustscan:2.0.0 -a $url -b 4000 -u 5000 -p 65535 | tee ~/recon/$DOM/Port_Scan/$url.txt
done
cd ~/recon/$DOM/Port_Scan/ 
sed -i -n '/nmap.org/,$p' *.txt
find ~/recon/$DOM/Port_Scan/ -size 0 -delete
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results ${reset}"
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
#waybackurls
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
#GFPattern
if [ -f ~/.gf/redirect.json ]
then
 echo "${magenta} [+] Running GF for pattern based scanning${reset}"
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf cors  >> ~/recon/$DOM/GF_Pattern/cors.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf aws-keys  >> ~/recon/$DOM/GF_Pattern/aws-keys.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf base64  >> ~/recon/$DOM/GF_Pattern/base64.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf s3-buckets >> ~/recon/$DOM/GF_Pattern/s3-buckets.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf idor | tee -a ~/recon/$DOM/GF_Patterns/idor.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf lfi | tee -a ~/recon/$DOM/GF_Patterns/lfi.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf rce | tee -a ~/recon/$DOM/GF_Patterns/rce.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf redirect | tee -a ~/recon/$DOM/GF_Patterns/redirect.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf sqli | tee -a ~/recon/$DOM/GF_Patterns/sqli.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf ssrf | tee -a ~/recon/$DOM/GF_Patterns/ssrf.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf ssti | tee -a ~/recon/$DOM/GF_Patterns/ssti.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf interestingparams | tee -a ~/recon/$DOM/GF_Patterns/interesting_parameters.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf interestingsubs | tee -a ~/recon/$DOM/GF_Patterns/interesting_subs.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf xss | tee -a ~/recon/$DOM/GF_Patterns/xss.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf interestingEXT | tee -a ~/recon/$DOM/GF_Patterns/interesting_extensions.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf debug_logic | tee -a ~/recon/$DOM/GF_Patterns/debug_logic.txt
else
 echo "${blue} [+] Installing GF_Patterns ${reset}"
 go get -u github.com/tomnomnom/gf
 git clone https://github.com/1ndianl33t/Gf-Patterns ~/recon/tools/Gf-Patterns
 mkdir ~/.gf
 mv ~/recon/tools/Gf-Patterns/*.json ~/.gf
 cp ~/go/src/github.com/tomnomnom/gf/examples/*.json ~/.gf
 echo "${blue} [+] Started GF for pattern based scanning${reset}"
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf cors | tee -a ~/recon/$DOM/GF_Patterns/cors.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf aws-keys | tee -a ~/recon/$DOM/GF_Patterns/aws-keys.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf base64 | tee -a ~/recon/$DOM/GF_Patterns/base64.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf s3-buckets | tee -a ~/recon/$DOM/GF_Patterns/s3-buckets.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf idor | tee -a ~/recon/$DOM/GF_Patterns/idor.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf lfi | tee -a ~/recon/$DOM/GF_Patterns/lfi.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf rce | tee -a ~/recon/$DOM/GF_Patterns/rce.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf redirect | tee -a ~/recon/$DOM/GF_Patterns/redirect.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf sqli | tee -a ~/recon/$DOM/GF_Patterns/sqli.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf ssrf | tee -a ~/recon/$DOM/GF_Patterns/ssrf.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf ssti | tee -a ~/recon/$DOM/GF_Patterns/ssti.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf interestingparams | tee -a ~/recon/$DOM/GF_Patterns/interesting_parameters.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf interestingsubs | tee -a ~/recon/$DOM/GF_Patterns/interesting_subs.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf xss | tee -a ~/recon/$DOM/GF_Patterns/xss.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf interestingEXT | tee -a ~/recon/$DOM/GF_Patterns/interesting_extensions.txt
 cat  ~/recon/$DOM/Archivescan/sorted.txt | gf debug_logic | tee -a ~/recon/$DOM/GF_Patterns/debug_logic.txt
fi
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results${reset}"
echo " "
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
cat ~/recon/$DOM/JSscan/jsfile_links_from_archives.txt ~/recon/$DOM/JSscan/jsfile_links_from_subjs.txt | sort -u jsfiles_result.txt
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results${reset}"
echo " "
#jsecret
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Started Gathering Live JsFiles-secret ${reset}"
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
#s3scanner
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f ~/recon/tools/S3Scanner/s3scanner.py ]
then
  echo "${magenta} [+] Running S3Scanner for S3 Bucket Enumeration${reset}"
  python3 ~/recon/tools/S3Scanner/s3scanner.py ~/recon/$DOM/Subdomains/protoless-all-alive-subs.txt &> ~/recon/$DOM/S3_Bucket_Recon/s3_temp_result.txt
  cat ~/recon/$1/$1-s3scanner.txt | grep "\[found\]" | cut -d" "  -f9- | tee -a ~/recon/bentley.com/S3_Bucket_Recon/s3_result.txt
  rm -rf ~/recon/$DOM/S3_Bucket_Recon/s3_temp_result.txt
else
  echo "${blue} [+] Installing S3Scanner ${reset}"
  git clone https://github.com/sa7mon/S3Scanner ~/recon/tools/S3Scanner
  pip install -r ~/recon/tools/S3Scanner/requirements.txt
  echo "${magenta} [+] Running S3Scanner for S3 Bucket Enumeration${reset}"
  python3 ~/recon/tools/S3Scanner/s3scanner.py ~/recon/$DOM/Subdomains/protoless-all-alive-subs.txt &> ~/recon/$DOM/S3_Bucket_Recon/s3_temp_result.txt
  cat ~/recon/$1/$1-s3scanner.txt | grep "\[found\]" | cut -d" "  -f9- | tee -a ~/recon/bentley.com/S3_Bucket_Recon/s3_result.txt
  rm -rf ~/recon/$DOM/S3_Bucket_Recon/s3_temp_result.txt
fi
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
#corsy
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
if [ -f ~/recon/tools/Corsy/corsy.py ]
then
  echo "${magenta} [+] Running cors scanner${reset}"
  python3 ~/recon/tools/Corsy/corsy.py -i ~/recon/$DOM/Subdomains/all-alive-subs.txt -t 25 -o ~/recon/$DOM/CORS_Scan/CORS_result.json
else
  echo "${blue} [+] Installing Corsy ${reset}"
  git clone https://github.com/s0md3v/Corsy ~/recon/tools/Corsy
  pip install -r ~/recon/tools/Corsy/requirements.txt
  echo "${magenta} [+] Running cors scanner${reset}"
  python3 ~/recon/tools/Corsy/corsy.py -i ~/recon/$DOM/Subdomains/all-alive-subs.txt -t 25 -o ~/recon/$DOM/CORS_Scan/CORS_result.json
fi
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
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

#scan web cache poisining
echo "${blue} [+] Started Scanning web cache poisining ${reset}"
echo " "

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
  cd ~/recon/tools/ForkCache; ./ForkCache --hostname $domains; cd -
  done
else
  bash src/subenum.sh
  echo "${green}[+] test web cache poisining"
  for domains in $(cat ~/recon/$DOM/Subdomains/all-alive-subs.txt);
  do
  cd ~/recon/tools/ForkCache; ./ForkCache --hostname $domains; cd -
  done
fi

echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results${reset}"
echo " "
echo "${yellow} ------------------------------------------------------------------------------ ${reset}"
#CHAT_ID=$(cat ~/recon/.tgcreds | grep "chat_id" | awk {'print $3'})
#TOKEN=$(cat ~/recon/.tgcreds | grep "token" | awk {'print $3'})
#MESSAGE="Scanning finished for $DOM"
#URL="https://api.telegram.org/bot$TOKEN/sendMessage"
#curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE" > /dev/null
 
