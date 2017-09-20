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
mv ./wordpress/wp-config-sample.php ./wordpress/wp-config.php		&& \
sed -i "s/database_name_here/${DB_NAME}/" ./wordpress/wp-config.php 	&& \
sed -i "s/username_here/${DB_USER}/" ./wordpress/wp-config.php 		&& \
sed -i "s/password_here/${DB_PASSWORD}/" ./wordpress/wp-config.php	&& \
cd /									&& \
mv $DIR/wordpress opt/lampp/htdocs/$SITE

