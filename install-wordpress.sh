#!/bin/sh

echo 'The name of the WordPress site:'
read SITE
echo 'The name of the database for WordPress:'
read DB_NAME


### by default database user should be 'root' and database password is ''
DB_USER='YOUR_DATABASE_USER';
DB_PASSWORD='YOUR_DATABASE_PASSWORD';

### if you always use the same db account comment out/delete the below lines:
echo 'mysql database username:'
read DB_USER
echo 'mysql database password:'
read DB_PASSWORD


/opt/lampp/lampp start;

echo Downloading and setting up the site...
curl -sS https://wordpress.org/latest.zip > wordpress.zip 		&& \
unzip wordpress.zip                                  			&& \
rm wordpress.zip							&& \
chmod a+rw wordpress -R							&& \
mv ./wordpress/wp-config-sample.php ./wordpress/wp-config.php		&& \
sed -i "s/database_name_here/${DB_NAME}/" ./wordpress/wp-config.php 	&& \
sed -i "s/username_here/${DB_USER}/" ./wordpress/wp-config.php 		&& \
sed -i "s/password_here/${DB_PASSWORD}/" ./wordpress/wp-config.php	&& \
mv ./wordpress /opt/lampp/htdocs/$SITE

echo Create the database on phpmyadmin...
/opt/lampp/bin/mysql -u$DB_USER -p$DB_PASSWORD -e"create database if not exists ${DB_NAME} CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"


################################## ftp settings #####################################
### by default FTP_USER should be 'daemon'
### by default FTP_HOST should be 'localhost'
### by default FTP_PASS should be ''

#echo "define('FTP_USER', 'YOUR-FTP-USER');" >> opt/lampp/htdocs/$SITE/wp-config.php
#echo "define('FTP_HOST', 'localhost');" >> opt/lampp/htdocs/$SITE/wp-config.php
#echo "define('FTP_PASS', 'YOUR-PASS');" >> opt/lampp/htdocs/$SITE/wp-config.php
#####################################################################################

xdg-open http://localhost/$SITE
