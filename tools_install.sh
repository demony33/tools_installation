#!/bin/bash

#check you are root or not
if [ "$EUID" -ne 0 ]
  then echo -n "Please run as root"
  exit
fi

printf "\x1b[32m ---> [ Installing jq ]\\x1b[0m\n"; # jq
apt install jq

#printf "\x1b[32m ---> [ update sourceslist ubuntu20.4 ]\\x1b[0m\n"; 
#cd /etc/apt/
#echo "deb http://th.archive.ubuntu.com/ubuntu jammy main" >> sources.list
#sudo apt update && sudo apt install libc6
cd ~

printf "\x1b[32m ---> [ Installing Go-lang ]\\x1b[0m\n"; # Go-lang
wget https://go.dev/dl/go1.20.3.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz
echo export PATH=$PATH:/usr/local/go/bin >> /etc/profile
source /etc/profile


printf "\x1b[32m ---> [ Update Your Linux Distro ]\\x1b[0m\n"; # Linux distro
apt-get -y update
apt-get -y upgrade

printf "\x1b[32m ---> [ Install pcap.h ]\\x1b[0m\n"; # pcap
sudo apt-get -y install libpcap-dev

printf "\x1b[32m ---> [Install Nmap]\\x1b[0m\n"; # nmap
cd ~
sudo apt -y install nmap

printf "\x1b[32m ---> [Install Amass]\\x1b[0m\n"; # amass
go install -v github.com/owasp-amass/amass/v3/...@master
cd ~/go/bin/
chmod +x amass
cp ~/go/bin/amass /usr/bin/

printf "\x1b[32m ---> [Install massdns]\\x1b[0m\n"; # massdns
cd ~
git clone https://github.com/blechschmidt/massdns.git
cd ./massdns
make
sudo make install

printf "\x1b[32m ---> [Downloading Wordlists]\\x1b[0m\n"; # wordlists-1
cd ~
mkdir ./wordlist
cd ./wordlist
curl -O https://wordlists-cdn.assetnote.io/data/manual/best-dns-wordlist.txt
curl -O https://wordlists-cdn.assetnote.io/data/manual/2m-subdomains.txt
curl -O https://raw.githubusercontent.com/tycho1101/wordlists/main/Spring.txt
curl -O https://raw.githubusercontent.com/tycho1101/wordlists/main/dir.txt
curl -O https://raw.githubusercontent.com/tycho1101/wordlists/main/dicc.txt
curl -O https://raw.githubusercontent.com/trickest/resolvers/main/resolvers-trusted.txt

printf "\x1b[32m ---> [Downloading SecLists]\\x1b[0m\n"; # wordlists-2
cd ~
git clone https://github.com/danielmiessler/SecLists.git

printf "\x1b[32m ---> [Install feroxbuster]\\x1b[0m\n"; # feroxbuster
curl -sL https://raw.githubusercontent.com/epi052/feroxbuster/master/install-nix.sh | bash
cp ./feroxbuster /usr/bin/

printf "\x1b[32m ---> [Install ffuf]\\x1b[0m\n"; #ffuf
go install github.com/ffuf/ffuf@latest
cd ~/go/bin/
chmod +x ffuf
cp ~/go/bin/ffuf /usr/bin/

printf "\x1b[32m ---> [Install pdtm]\\x1b[0m\n"; # pdtm
go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest
cd ~/go/bin/
chmod +x pdtm
cp ~/go/bin/pdtm /usr/bin/

printf "\x1b[32m ---> [Install projectdiscovery_tools]\\x1b[0m\n";
pdtm -i nuclei,subfinder,httpx,shuffledns,katana,dnsx # projectdiscovery_tools
cd $HOME/.pdtm/go/bin/
chmod +x nuclei subfinder httpx shuffledns katana dnsx notify
cp nuclei subfinder httpx shuffledns katana notify /usr/bin/

printf "\x1b[32m ---> [Install naabu]\\x1b[0m\n"; #pdtm can't install

go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
cd ~/go/bin
chmod +x naabu
cp ~/go/bin/naabu /usr/bin/

printf "\x1b[32m ---> [Install puredns]\\x1b[0m\n"; # DNS_filter
go install github.com/d3mondev/puredns/v2@latest
chmod +x puredns
cp ~/go/bin/puredns /usr/bin/

printf "\x1b[32m ---> [Install anew]\\x1b[0m\n"; # tonnomnom_anew
go install -v github.com/tomnomnom/anew@latest
cd ~/go/bin/
chmod +x anew
cp ~/go/bin/anew /usr/bin/

printf "\x1b[32m ---> [Install url_crawl]\\x1b[0m\n"; #url_crawl_tools
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/tomnomnom/waybackurls@latest
cd ~/go/bin/
chmod +x gau waybackurls
cp ~/go/bin/gau waybackurls /usr/bin/

cd ~

git clone https://github.com/Bb12l/one-scan.git

export PATH=$PATH:/usr/local/go/bin

rm -rf ~/go1.20.3.linux-amd64.tar.gz
