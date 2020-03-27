#!/bin/bash -ex

#Get some pre-req software installed first
curl -O https://ftp.gnu.org/gnu/wget/wget-1.19.5.tar.gz
tar -zxvf wget-1.19.5.tar.gz
cd wget-1.19.5/
./configure --with-ssl=openssl
make
make install

#Check if VLC is installed.  Then, get the latest VLC install .dmg file if needed
if [ -d /Applications/VLC.app ]  
then
  echo "VLC is already installed"
else
  echo "Downloading VLC from https://get.videolan.org"
  cd ~/Downloads
  wget https://get.videolan.org/vlc/3.0.8/macosx/vlc-3.0.8.dmg 
  #Need to mount and install the dmg file:
  http://commandlinemac.blogspot.com/2008/12/installing-dmg-application-from-command.html
fi
  


#First get the repo, git should be installed on OSX by default
git clone https://github.com/mortsnake/vlc-protocol.git /tmp/vlc-protocol

#CD into dir, run the build script.  This should compile successfully
cd /tmp/vlc-protocol/mac
./build.sh 

#Copy app into Applications dir
cp -r /tmp/vlc-protocol/mac/VLC-protocol-app /Applications/VLC-protocol.app

#Instruct user to complete some instructions
echo "In a second, your web browser will open up.  When a pop-up asking you to do something with the file type shows up, select 'always use'
echo "In Firefox, you might have to 'choose another application' and select 'VLC-protocol'.  Make sure to select 'remember my choice'
echo "Safari is dumb, like usual and might not work.  I would recommend using Chrome or Firefox in general, anyways."
echo ""
echo "If you would like to download 

#Open up a link in web browser to set this file type association
open -a /Applications/Firefox.app vlc://https://mortis.moe
