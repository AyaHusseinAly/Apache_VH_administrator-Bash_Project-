### script to view Options menu

#source controller.sh

function displayMenu {

PS3='Please enter your choice: '
options=("Install Apache" "Remove Apache" "Start Apache" "Stop Apache" "Adminstrate VirtualHosts" "Configure Authentication" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Install Apache")
                install_apache
            ;;
         "Remove Apache")
		remove_apache
                #read -p "Enter item name: " Name
                #read -p "Enter inv_id: "  id
                #read -p "Enter inv_quantity: " q                                                                                                                 read ->                read -p "Enter inv_unit_price: "  up

                #echo "Remove Apache"
            ;;
	"Start Apache")
		start_apache
		echo "Apache Started"
		;;
	"Stop Apache")
		stop_apache
		echo "Apache Stop"
        	;;
	"Adminstrate VirtualHosts")
                #read -p "Enter invoice id: "  id

            echo "Adminstrate VirtualHosts"
            ;;
        "Configure Authentication")
            echo "Configure Authentication"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
}
