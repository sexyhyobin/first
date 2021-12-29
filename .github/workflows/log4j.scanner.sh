#!/bin/bash

file_dir="/usr/share/AISpera"

if [ ! -d "$file_dir" ]; then
  echo -e "Making AISpera folder"
  sudo mkdir "$file_dir"
  sudo chown rundeck /usr/share/AISpera
  sudo chmod -R o+rwx /usr/share/AISpera/
fi

file_dir="/usr/share/AISpera/Log4j"

if [ -d "$file_dir" ]; then
  echo -e "Removing existing(older) directory"
  sudo rm -r "$file_dir"
fi

sudo mkdir /usr/share/AISpera/Log4j
sudo chown rundeck /usr/share/AISpera/Log4j

cd '/usr/share/AISpera/Log4j'
FILE="/usr/share/AISpera/Log4j/logpresso-log4j2-scan-2.6.5-linux.tar.gz"
if [ ! -e $FILE ]; then
    sudo wget https://github.com/logpresso/CVE-2021-44228-Scanner/releases/download/v2.6.5/logpresso-log4j2-scan-2.6.5-linux.tar.gz
fi

FILE="/usr/share/AISpera/Log4j/logpresso-log4j2-scan-2.6.5-linux.tar.gz"
if [ -e $FILE ]; then
    sudo unzip -d $FILE
    tar -xvf $FILE
fi
sudo chmod 755 log4j2-scan

# Logpresso scanner 실행 

HOSTNAME_S=`hostname -s`

DIR="/"

if [ -d $DIR ]; then
    sudo  ./log4j2-scan --scan-log4j1 --report-json --report-path $HOSTNAME_S.json  $DIR
fi
