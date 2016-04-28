####################################
# installing tightvncserver
# many many thanks to Russell Davis for all the hints!
####################################

# get default password from the argument
DEFAULT_PWD=$1
if [[ -z "${DEFAULT_PWD// }" ]] ; then
echo "Tightvncserver needs a password"
exit
fi

sudo apt-get install tightvncserver expect -y
/usr/bin/expect <<EOF
spawn "/usr/bin/tightvncserver"
expect "Password:"
send "$DEFAULT_PWD\r"
expect "Verify:"
send "$DEFAULT_PWD\r"
expect "(y/n?"
send "n\r"
expect eof
EOF
sudo apt-get remove expect -y

# change cursor
sed -i 's/grey/grey -cursor_name left_ptr/g'  ./.vnc/xstartup 
chmod +x ./.vnc/xstartup

#install systemd service
wget https://raw.githubusercontent.com/CleoQc/Raspbian_Scripts/master/vncserver.service
sudo cp tightvncserver.service /etc/systemd/system/vncserver@.service
sudo systemctl daemon-reload && sudo systemctl enable vncserver@1.service
sudo systemctl start vncserver@1.service

# cleanup
rm vncserver.service
