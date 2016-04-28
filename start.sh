DEFAULT_PWD=raspberry
CUSTOMDIR=customraspbian
HOMEDIR=/home/pi

cd $HOMEDIR
mkdir $CUSTOMDIR
cd $CUSTOMDIR


wget https://raw.githubusercontent.com/CleoQc/Raspbian_Scripts/master/samba_install.sh
bash samba_install.sh $DEFAULT_PWD
rm samba_install.sh

wget https://raw.githubusercontent.com/CleoQc/Raspbian_Scripts/master/tightvncserver.sh
bash tightvncserver.sh $DEFAULT_PWD
rm tightvncserver.sh

cd ..
rm -r $HOMEDIR/$CUSTOMDIR
