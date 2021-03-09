#!/bin/bash
### Script to control apache services

### Function to start Apache

function start_apache {
	sudo service apache2 start
}

### Function to stop Apache
function stop_apache {
	sudo service apache2 stop

}
### Function to install Apache
function install_apache {
        sudo apt-get update
	sudo apt-get install apache2

}
function remove_apache {
	stop_apache
	sudo apt-get remove apache2
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


