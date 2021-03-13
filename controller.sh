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
### Function to uninstall apache and remove related files
function remove_apache_fn {
	stop_apache
	sudo apt-get purge apache2
}
function create_vh_fn {
	root_dir=/var/www/${1}/html
	touch /etc/apache2/sites-available/${1}.conf
	mkdir -p $root_dir
	touch $root_dir/index.html
	echo '<h1>Hello you are connected to' ${1}'!</h1>' >$root_dir/index.html
	echo "<VirtualHost *:80>
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
	sudo service apache2 reload
	sudo service apache2 restart

	echo "your virtual host root directory is >>>>>>> " $root_dir" <<<<<<<"
}
function enable_vh_fn {
        sudo a2ensite ${1}.conf
	#if grep -Fxq "${1}" /etc/hosts
	#then
	#else
   	 sudo echo "127.0.0.1 "${1} >> /etc/hosts
	#fi
        sudo service apache2 reload
	sudo service apache2 restart

}

function disable_vh_fn {
        sudo a2dissite ${1}.conf
	sudo sed -i '/'${1}'/d' /etc/hosts
        sudo service apache2 restart
}

function delete_vh_fn {
	sudo sed -i '/'${1}'/d' /etc/hosts
	sudo service apache2 restart
	root_dir=/var/www/${1}/html
        sudo rm /etc/apache2/sites-available/${1}.conf
        sudo rm -r $root_dir

	echo "virtual host "${1}" is deleted successfully"
}
function Adminstrate_VirtualHosts_fn
{

PS3='Please enter your choice: '
options=("Add new VH" "delete existing VH" "Enable VH" "Disable VH" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Add new VH")
	    read -p 'Enter Server Name: ' srvr_nm
            create_vh_fn $srvr_nm
            ;;
        "delete existing VH")
            read -p 'Enter Server Name: ' srvr_nm
            delete_vh_fn $srvr_nm
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


function authenticate_vh_fn
{

PS3='Please enter your choice: '
options=("Add new user and password" "Restrict VH website" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Add new user and password")
            read -p 'Enter user name: ' usr_nm
         #  sudo apt-get update
         #  sudo apt-get install apache2 apache2-utils
     	    sudo htpasswd -c /etc/apache2/.htpasswd $usr_nm


            ;;
        "Restrict VH website")
            read -p 'Enter Server Name to retrict: ' srvr_nm
            restrict_fn $srvr_nm
            echo $srvr_nm" website has been restricted successfully"
	    ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

}

function restrict_fn
{
        root_dir=/var/www/${srvr_nm}/html
        echo "<VirtualHost *:80>
        ServerAdmin admin@ayahussein.com
        ServerName ${srvr_nm}
        DocumentRoot $root_dir
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        <Directory /var/www/${srvr_nm}/html>
                Options Indexes FollowSymLinks
                AllowOverride All

                AuthType Basic
                AuthName 'Restricted Content'
                AuthUserFile /etc/apache2/.htpasswd
                Require valid-user

        </Directory>
        </VirtualHost>" >/etc/apache2/sites-available/${srvr_nm}.conf

	sudo service apache2 restart
}

