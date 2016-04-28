########################################################################
########################################################################
# Call this script by passing the desired password as the first parameter
########################################################################
########################################################################

########################################################################
# Checking password
########################################################################

DEFAULT_PWD=$1
if [[ -z "${DEFAULT_PWD// }" ]] ; then
echo "Samba needs a password"
exit
fi

########################################################################
# Installing Samba
########################################################################

sudo apt-get install -y samba samba-common
sudo cp /etc/samba/smb.conf .
sudo chown pi:pi smb.conf
sudo sed -i 's/read only = yes/read only = no/g' smb.conf

# the security = user line is needed if we want to password protect the SD card
sudo echo 'security = user' >> smb.conf

sudo chown root:root smb.conf
sudo cp smb.conf /etc/samba/smb.conf
sudo systemctl restart smbd.service

# smbpasswd won't take a redirection of the type 
# echo $1\r$1| smbpassd -a pi
# so we do it the long way
echo $DEFAULT_PWD > smbpasswd.txt
echo $DEFAULT_PWD >> smbpasswd.txt
sudo smbpasswd -a pi < smbpasswd.txt
sudo rm smbpasswd.txt # sudo not needed, it's there to be consistent and look pretty
sudo rm smb.conf
