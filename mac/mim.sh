#!/bin/bash

#Get some pre-req software installed first
#Check if Wget installed
if [ ! `command -v wget` ]
then
  echo ""
  echo "Working on system tools:"
  cd ~/Downloads
  curl -O https://ftp.gnu.org/gnu/wget/wget-1.19.5.tar.gz
  tar -zxvf wget-1.19.5.tar.gz
  cd wget-1.19.5/
  echo "    Installing..."
  ./configure --with-ssl=openssl
  make
  make install
  echo "    System tools completed!"
fi

#Check if VLC is installed.  Then, get the latest VLC install .dmg file if needed
echo ""
echo "Working on VLC app:"
if [ -d /Applications/VLC.app ]  
then
  echo "    VLC is already installed!  Skipping this step..."
else
  echo "    Downloading..."
  cd ~/Downloads
  if [ ! -f vlc-3.0.8.dmg ]
  then
    wget https://get.videolan.org/vlc/3.0.8/macosx/vlc-3.0.8.dmg 
  fi
  #Need to mount and install the dmg file:
  #http://commandlinemac.blogspot.com/2008/12/installing-dmg-application-from-command.html
  hdiutil mount vlc-3.0.8.dmg 1> /dev/null
  echo "    Installing...  This might take a second!"
  cp -r /Volumes/VLC\ media\ player/VLC.app /Applications/VLC.app
  echo "    Cleaning up..."
  hdiutil unmount /Volumes/VLC\ media\ player
  echo "    VLC complete!"
fi

#First get the repo, git should be installed on OSX by default
echo ""
echo "Working on VLC-Protocol association:"
if [ ! -d /tmp/vlc-protocol ]
then
  git clone https://github.com/mortsnake/vlc-protocol.git /tmp/vlc-protocol 1> /dev/null
fi

#CD into dir, run the build script.  This should compile successfully
cd /tmp/vlc-protocol/mac
echo "    Building..."
./build.sh 

#Copy app into Applications dir
echo "    Installing..."
cp -r /tmp/vlc-protocol/mac/VLC-protocol-app /Applications/MortIsMoe\ Streaming.app
echo "    VLC-Protocol Add-On Complete"

#Will remove all downloaded files and stuff to free up space
echo ""
echo "Working on cleaning up loose files..."
rm -rf /tmp/vlc-protocol
rm -rf ~/Downloads/wget-1.19.5.tar.gz
echo "    Clean-up complete!"

#Instruct user to complete some instructions
echo ""
echo ""
echo "-In a second, your web browser will open up."
echo "-A pop-up will appear asking you if you want to open the app, choose yes"
echo "-In Firefox, you might have to 'choose another application' and select 'MortIsMoe_Streaming'."  
echo "-Make sure to select 'remember my choice'"
echo "-Safari is dumb, like usual and might not work."
echo "-I would recommend using Chrome or Firefox in general, anyways."
echo ""
echo "Just press enter if you don't want to download any new browsers," 
echo "or if you already have another browser"
echo ""
echo "    1) Download Firefox"
echo "    2) Download Chrome"
echo "    3) Don't download anything new (default)"
echo ""

read -p "    Make Choice or Press Enter To Do Nothing: " ANSWER

case "$ANSWER" in 
  [1]|[Ff]*) 
    wget https://ftp.mozilla.org/pub/firefox/releases/75.0b9/mac/en-US/Firefox\ 75.0b9.dmg
    #Mount and install here
    open -a /Applications/Firefox.app vlc://https://mortis.moe
    ;;
  [2]|[Cc]*)
    open -a /Applications/Safari.app https://www.google.com/chrome/thank-you.html?brand=CHBD&statcb=0&installdataindex=empty&defaultbrowser=0#
    read -p "Press enter after Chrome is done installing..." STALLING
    open -a /Applications/Google\ Chrome.app vlc://https://mortis.moe
    ;;
  *)
    open vlc://https://mortis.moe
    ;; 
esac
    
echo ""
echo "" 
echo "All set!  Please contact Mort if you have any questions"
