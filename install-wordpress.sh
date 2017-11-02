#!/bin/sh

echo 'The name of the WordPress site'
read SITE
echo 'The name of the database for WordPress'
read DB_NAME
echo 'MySQL database username'
read DB_USER
echo 'MySQL database password'
read DB_PASSWORD

DIR=${PWD}

curl -sS https://wordpress.org/latest.zip > wordpress.zip 		&& \
unzip wordpress.zip                                  			&& \
rm wordpress.zip							&& \
chmod a+rw wordpress -R							&& \
mv ./wordpress/wp-config-sample.php ./wordpress/wp-config.php		&& \
sed -i "s/database_name_here/${DB_NAME}/" ./wordpress/wp-config.php 	&& \
sed -i "s/username_here/${DB_USER}/" ./wordpress/wp-config.php 		&& \
sed -i "s/password_here/${DB_PASSWORD}/" ./wordpress/wp-config.php	&& \
cd /									&& \
mv $DIR/wordpress opt/lampp/htdocs/$SITE

### create the database on phpmyadmin
/opt/lampp/bin/mysql -u$DB_USER -p$DB_PASSWORD -e"create database if not exists ${DB_NAME}"

### ftp settings
### by default FTP_USER should be daemon
### by default FTP_HOST should be localhost
### by default FTP_PASS should be empty
#echo "define('FTP_USER', 'YOUR-FTP-USER');" >> opt/lampp/htdocs/$SITE/wp-config.php
#echo "define('FTP_HOST', 'localhost');" >> opt/lampp/htdocs/$SITE/wp-config.php 	
#echo "define('FTP_PASS', 'YOUR-PASS');" >> opt/lampp/htdocs/$SITE/wp-config.php
