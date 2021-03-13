
### FN to display the authentication menu and call the required function 
# has two options whether to add password or choose a website to restrict
function authenticate_vh_fn
{

PS3='Please enter your choice: '
options=("Add new user and password" "Restrict VH website" "Unrestrict VH website" "Quit")
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
	    ;;
        "Unrestrict VH website")
            read -p 'Enter Server Name to unetrict: ' srvr_nm
            unrestrict_fn $srvr_nm
	    ;;

        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

}

### FN to restrict a specifc website in the following steps:
#   check if the entry is existing website name
#   if exists update the config file to remove require all granted and add authen of basic type
#   if doesn't exist echo an error message
function restrict_fn
{
        file='/etc/apache2/sites-available/'${1}'.conf'
        if [[ -f $file ]]; then
            if grep -q "AuthType" "$file" ;
            then
                   echo "this website is already restricted"
            else       
                sudo a2dissite ${1}.conf
                sudo sed -i '/Require all granted/d' $file
                sudo sed -i '/<\/Directory>/d' $file      
                sudo sed -i '/<\/VirtualHost>/d' $file   
                sudo echo "                    
                        AuthType Basic
                        AuthName 'Restricted Content'
                        AuthUserFile /etc/apache2/.htpasswd
                        Require valid-user 
                    </Directory>
                </VirtualHost>" >> $file


                sudo a2ensite ${1}.conf
                sudo service apache2 restart
                echo ${1}" website has been restricted successfully"
          
             
            fi    

        else
            echo "website ${1} does not exist."
        fi
}
### FN to remove restriction from already restricted website
function unrestrict_fn
{
        sudo a2dissite ${1}.conf
        file='/etc/apache2/sites-available/'${1}'.conf'
        sudo sed -i '/AuthType/d' $file
        sudo sed -i '/AuthName/d' $file
        sudo sed -i '/AuthUserFile/d' $file
        sudo sed -i '/Require valid-user/d' $file
        sudo sed -i '/<\/Directory>/d' $file      
        sudo sed -i '/<\/VirtualHost>/d' $file   
        sudo echo   "
                	Require all granted
     </Directory>
</VirtualHost>" >>$file

        sudo a2ensite ${1}.conf
        sudo service apache2 restart
        
}