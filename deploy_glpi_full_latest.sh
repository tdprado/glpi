sed -i 's/enforcing/disabled/g' /etc/selinux/config
setenforce 0
yum install -y wget yum-utils
wget https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
wget https://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -Uvh epel-release-7-11.noarch.rpm
rpm -Uvh remi-release-7.rpm
yum-config-manager --enable remi-php72
yum install -y httpd
systemctl enable httpd
systemctl start httpd
wget https://raw.githubusercontent.com/tdprado/glpi/master/MariaDB.repo -O /etc/yum.repos.d/MariaDB.repo
yum install -y MariaDB-server MariaDB-client
systemctl enable mariadb.service
systemctl start mariadb.service
mysql_secure_installation
#yum install -y php php-gd php-mysql php-mcrypt* php-apcu* php-xmlrpc php-pecl-zendopcache* php-ldap php-imap php-mbstring php-simplexml* php-xml php-pear-CAS
yum install -y php php-gd php-mysql php-xmlrpc php-ldap php-imap php-mbstring php-xml php-pear-CAS
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
wget https://github.com/glpi-project/glpi/releases/download/9.3.1/glpi-9.3.1.tgz -O /var/www/html/glpi-9.3.1.tgz
cd /var/www/html/
tar xvf glpi-9.3.1.tgz
chmod -R 755 glpi
chown -R apache:apache glpi
systemctl restart httpd
