### script to view Main Options menu


function displayMenu {
echo 'Welcome '$(whoami)' to Apache web server administrator'
PS3='Please enter your choice: '
options=( "Show Apache status" "Install Apache" "Remove Apache" "Start Apache" "Stop Apache" "display available websites" "Adminstrate VirtualHosts" "Configure Authentication" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Show Apache status")
		service apache2 status
	;;
	"Install Apache")
                install_apache_fn

		;;
    "Remove Apache")
		remove_apache_fn

            ;;
	"Start Apache")
		start_apache_fn

		;;
	"Stop Apache")
		stop_apache_fn

		
        	;;
    "display available websites")
                sudo ls /etc/apache2/sites-available
		;;        
	"Adminstrate VirtualHosts")
                #read -p "Enter invoice id: "  id

            	Adminstrate_VirtualHosts_fn
            ;;
    "Configure Authentication")
           authenticate_vh_fn
	   #echo "Configure Authentication"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
}
