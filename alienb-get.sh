#!/bin/bash

while true; do

# Ask the user for the Program name
echo -e "\e[1;33m what Alian Bob program do you need?\e[0m"
read prgname
echo -e "\e[1;34m It's ok lets download or install $prgname \e[0m"
sleep 2
PROGNM=$prgname 


# Need the version of Slackware you are running
echo -e "\e[1;33m Enter the version number of Slackware you need to download ? \e[0m"
read slackwareversion
echo -e "\e[1;34m You chose slackware version $slackwareversion \e[0m"
sleep 2
SLKVER=$slackwareversion



# Need the version of Slackware you are downloading
echo -e "\e[1;33m Type yes or no to install? \e[0m"
read install
echo -e "\e[1;33m Are going to install $install \e[0m"
sleep 2
INST=$install




EDITPG=kwrite # add you favorite editor here defaylt is vim kwrite,kate,gvim,geany.

if [ -z "$ARCH" ]; then
  case "$( uname -m )" in
    i?86) ARCH=i486 ;;
    arm*) ARCH=arm ;;
       *) ARCH=$( uname -m ) ;;
  esac
fi



CWD=$(pwd)
TMP=${TMP:-$CWD/Alien/$SLKVER}
BOB=$TMP/$PROGNM

if [ "$ARCH" = "x86_64" ]; then
PKG="pkg64"
else
PKG="pkg"
fi

#rm -rf $BOB
mkdir -p $TMP/$PROGNM
echo going to grab slackware.uk/people/alien/slackbuilds/$PROGNM/$PKG/$SLKVER/
 sleep 5 #http://slackware.uk/people/alien/slackbuilds/
rsync -r -a -v  --delete --progress --stats rsync://slackware.uk/people/alien/slackbuilds/$PROGNM/$PKG/$SLKVER/  $TMP/$PROGNM

echo $TMP
cd $TMP


# slackware version
SLKVERIN="$(cat /etc/slackware-version |head -1)"
if [ "$SLKVERIN" = "Slackware 14.0" ]; then
  SLKUSYS="14.0"
elif [ "$SLKVERIN" = "Slackware 14.1" ]; then
  SLKUSYS="14.1"
elif [ "$SLKVERIN" = "Slackware 14.2" ]; then
  SLKUSYS="14.2"
elif [ "$SLKVERIN" = "Slackware 15.0" ]; then
  SLKUSYS="15.0"
else
  SLKUSYS="current"
fi

echo $SLKUSYS
echo $SLKVER
sleep 5
if [ "$SLKVER" = "$SLKUSYS" ]; then
   echo -e "\e[1;34m Your Installing the right program for your system \e[0m"
   sleep 3
elif [ "$INST" = "no" ]; then
   echo -e "\e[1;34m it is downloaded do not install on this system  \e[0m"
else
   echo -e '\E[37;41m'"\033[1m !!!!Unable TO Istall You are running the wrong Slackware Version !!!!\033[0m"
   sleep 5
   exit 1
fi



if [ -f  $TMP/$PROGNM/*.dep ]; then
   echo -e "\e[1;33m This Program Has Dependencies exit vim press shit>colon then type q  \e[0m"
   echo -e "\e[1;33m or a gui editor gvim kwrite  \e[0m"
    sleep 5
     $EDITPG  $TMP/$PROGNM/*.dep 
     
function pause(){
   read -p "$*"
}

# ...
   echo -e "\e[1;33m Look at them good you may need them. \e[0m"
pause 'Press [Enter] key to continue or ctrl c to stop...'
# ...
else
    echo -e "\e[1;33m No dependencies needed \e[0m"
    sleep 3
fi


if [ -f   $BOB/*.t?z ]; then
  echo -e "\e[1;33m $PROGNM downloaded \e[0m"
  sleep 1


if [ "$INST" = "yes" ]; then
  echo type in your root password
    cd  $BOB
 su  -c   "upgradepkg --reinstall --install-new *.t?z"
else
    echo -e "\e[1;33m your program is locate $BOB \e[0m"
    sleep 3
fi

else

function pause(){
   read -p "$*"
}
 
# ...
  echo -e "\e[1;33m Program  Not found. Was It Spelled Right? \e[0m"
  echo -e "\e[1;33m  Would you like to look it up? press enter to see the repo \e[0m"
pause 'Press [Enter] key to continue or ctrl c to stop...'
# ...
firefox  http://slackware.uk/people/alien/slackbuilds/

fi


function pause(){
   read -p "$*"
}
 
# ...
   echo -e "\e[1;33m Would you like to install or download another alien pkg \e[0m"
pause 'Press [Enter] key to continue or ctrl c to stop...'
# ...
# rest of the script
#

    for i in {Type In another Program}; do
        echo $i
        sleep 1
    done
done
