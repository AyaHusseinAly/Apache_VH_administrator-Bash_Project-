


##################################  this file has Functions called by the VH_menu   ###########################################

function disable_vh_fn {
        sudo a2dissite ${1}.conf
	    sudo sed -i '/'${1}'/d' /etc/hosts
        sudo service apache2 restart
}

function enable_vh_fn {
    sudo a2ensite ${1}.conf
	#if grep -Fxq "${1}" /etc/hosts
	#then
	#else
   	 sudo echo "127.0.0.1 "${1} >> /etc/hosts
	#fi
    
	sudo service apache2 restart

}
function create_vh_fn {
	root_dir=/var/www/${1}/html
	sudo touch /etc/apache2/sites-available/${1}.conf
	sudo mkdir -p $root_dir
	sudo touch $root_dir/index.html
	sudo echo '<h1>Hello you are connected to' ${1}'!</h1>' >$root_dir/index.html
	sudo echo "<VirtualHost *:80>
	ServerAdmin admin@ayahussein.com
	ServerName ${1}
	DocumentRoot $root_dir
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
	<Directory /var/www/${1}/html>
        	Options Indexes FollowSymLinks
       		AllowOverride All
        	Require all granted
	</Directory>
	</VirtualHost>" >/etc/apache2/sites-available/${1}.conf

	sudo chmod 777 /etc/hosts
	sudo echo "127.0.0.1	"${1} >> /etc/hosts
	sudo a2ensite ${1}
	sudo service apache2 restart

	echo "your virtual host root directory is >>>>>>> " $root_dir" <<<<<<<"
}

### FN to delete previusly added VH in the following steps:
#   remove its name from this device hosts list
#   disable this vh
#   remove its conf file from sites-available
#   remove its root directory with its index file
#   restart apache

function delete_vh_fn {
	sudo sed -i '/'${1}'/d' /etc/hosts
    sudo a2dissite ${1}.conf
    sudo rm /etc/apache2/sites-available/${1}.conf
    sudo rm -Rf /var/www/${1}
	sudo service apache2 restart
	echo "virtual host "${1}" is deleted successfully"
}