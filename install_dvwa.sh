#!/bin/bash


#DVWA Installer Script


echo "[*] Updating Packages..."

sudo apt update -y && sudo apt upgrade -y

echo "[*] Installing Apache, Mariadb and php extensions needed for dvwa ..."

sudo apt install apache2 mariadb-server php php-mysqli php-gd php-zip libapache2-mod-php -y
sudo apt install php-mbstring php-curl php-xml -y
sudo phpenmod mbstring
sudo phpenmod mysqli gd

echo "[*] Starting Neccessary Services..."

sudo systemctl start apache2
sudo systemctl start mysql
sudo systemctl start mariadb

echo "[*] Downloading DVWA"
cd /var/www/html/
if [ ! -d "dvwa" ]; then
   sudo git clone https://github.com/digininja/DVWA dvwa
   sudo chown -R www-data:www-data dvwa
   echo "DVWA Downloaded Successfully"
else
   echo "DVWA already exists"
fi

echo "[*]Creating DVWA Database..."



sudo mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS dvwa;
CREATE USER IF NOT EXISTS 'dvwa'@'localhost' IDENTIFIED BY 'p@ssw0rd';
GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'localhost';
FLUSH PRIVILEGES;
EOF



echo "[*]Creating Config File..."
cd dvwa/config
if [ ! -f "config.inc.php" ]; then
   sudo cp config.inc.php.dist config.inc.php
   echo "config file created"
else
   echo "config file already exists"
fi

sudo systemctl restart apache2

echo "DVWA Setup Complete"
echo "Make sure the /var/www/html/dvwa/config/config.inc.php contains db_user:dvwa and db_password:p@ssw0rd"
echo "Open http://localhost/dvwa/setup.php and chick create/reset database"
echo "Open http://localhost/dvwa is your browser"
echo "default username and password is admin|password"
