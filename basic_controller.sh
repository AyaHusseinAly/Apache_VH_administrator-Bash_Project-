#!/bin/bash
### Script to control apache services

### Function to start Apache

function start_apache_fn {
	sudo service apache2 start

		echo "Apache Started"
}

### Function to stop Apache
function stop_apache_fn {
	sudo service apache2 stop
    echo "Apache Stopped"

}
### Function to install Apache
function install_apache_fn {
    sudo apt-get update
	sudo apt-get install apache2
    

}
### Function to uninstall apache and remove related files
function remove_apache_fn {
        read -p 'Are you sure you want to uninstall apache [y/n]' confirm
        if [[ $confirm == [yY] ]];
        then
        	stop_apache
	        sudo apt-get purge apache2
        fi

}
