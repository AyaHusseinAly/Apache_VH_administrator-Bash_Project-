#!/bin/bash
### Script to control apache services

### Function to start Apache

function start_apache_fn {
	sudo service apache2 start
}

### Function to stop Apache
function stop_apache_fn {
	sudo service apache2 stop

}
### Function to install Apache
function install_apache_fn {
        sudo apt-get update
	sudo apt-get install apache2

}
function remove_apache_fn {
	stop_apache
	sudo apt-get remove apache2
}
function create_vh_fn {
	root_dir=/var/www/${1}/html
	touch /etc/apache2/sites-available/${1}.conf
	mkdir -p $root_dir
	touch $root_dir/index.html
	echo '<h1>Hello you are connected to' ${1}'!</h1>' >$root_dir/index.html
	echo "<VirtualHost *:80>
	ServerAdmin admin@emanhussein.com
	ServerName ${1}
	ServerAlias ${2}
	DocumentRoot $root_dir
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
	<Directory /var/www/emanhussein.com/html>
        	Options Indexes FollowSymLinks
       		AllowOverride All
        	Require all granted
	</Directory>
	</VirtualHost>" >/etc/apache2/sites-available/${1}.conf

	sudo chmod 777 /etc/hosts
	sudo echo "127.0.0.1 "${1} >> /etc/hosts
	sudo a2ensite ${1}
	sudo service apache2 restart

	echo "your virtual host root directory is " $root_dir
}
function enable_vh_fn {
        sudo a2ensite ${1}.conf
        sudo service apache2 restart
}

function disable_vh_fn {
        sudo a2dissite ${1}.conf
        sudo service apache2 restart
}


function Adminstrate_VirtualHosts_fn
{

PS3='Please enter your choice: '
options=("Add new VH" "Enable VH" "Disable VH" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Add new VH")
	    read -p 'Enter Server Name: ' srvr_nm
            read -p 'Enter Server Alias: ' srvr_als
            create_vh_fn $srvr_nm $srvr_als
            ;;
        "Enable VH")
	    read -p 'Enter server Name to enable: ' srvr_nm
	    enable_vh_fn $srvr_nm
            ;;
        "Disable VH")
            read -p 'Enter server Name to disable: ' srvr_nm
	    disable_vh_fn $srvr_nm
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
}

#       if [ $(/etc/init.d/apache2 status | grep -v grep | grep 'Apache2 is running' | wc -l) > 0 ]
#       then
#               echo "Apache is already running."
#               exit 1
#       else
#               #echo "Process is not running."
#               sudo service apache2 restart
#               exit 0
#       fi


