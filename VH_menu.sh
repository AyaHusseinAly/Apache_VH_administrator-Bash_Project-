function Adminstrate_VirtualHosts_fn
{

PS3='Please enter your choice: '
options=("Add new VH" "delete existing VH" "Enable VH" "Disable VH" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Add new VH")
	    read -p 'Enter Server Name: ' srvr_nm
        file='/etc/apache2/sites-available/'${srvr_nm}'.conf'
        if [[ -f $file ]]; then
            echo "this server is already exist you may enable it instead"
            
        else
            create_vh_fn $srvr_nm
        fi    
            ;;
        "delete existing VH")
            read -p 'Enter Server Name: ' srvr_nm
            file='/etc/apache2/sites-available/'${srvr_nm}'.conf'
            if [[ -f $file ]]; then
                read -p 'Are you sure you want to delet '$srvr_nm'[y/n]' confirm
                if [[ $confirm == [yY] ]];
                then
                    delete_vh_fn $srvr_nm
                fi
            else
                echo "this virtual host doesn't exist"
            fi    
            ;;

        "Enable VH")
	        read -p 'Enter server Name to enable: ' srvr_nm
            file='/etc/apache2/sites-available/'${srvr_nm}'.conf'
            if [[ -f $file ]]; then
                enable_vh_fn $srvr_nm
            else
                echo "this virtual host doesn't exist"
            fi             
                ;;
        "Disable VH")
                read -p 'Enter server Name to disable: ' srvr_nm
                file='/etc/apache2/sites-available/'${srvr_nm}'.conf'
                if [[ -f $file ]]; then
                    disable_vh_fn $srvr_nm
                else
                    echo "this virtual host doesn't exist"
                fi  
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
}