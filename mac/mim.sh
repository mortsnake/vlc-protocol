#!/bin/bash -ex

#Get some pre-req software installed first
echo "Working on system tools:"
curl -O https://ftp.gnu.org/gnu/wget/wget-1.19.5.tar.gz
tar -zxvf wget-1.19.5.tar.gz
cd wget-1.19.5/
echo "    Installing..."
./configure --with-ssl=openssl
make
make install
echo "    System tools completed!\n"

#Check if VLC is installed.  Then, get the latest VLC install .dmg file if needed
echo "Working on VLC app:"
if [ -d /Applications/VLC.app ]  
then
  echo "    VLC is already installed!  Skipping this step..."
else
  echo "    Downloading..."
  cd ~/Downloads
  wget https://get.videolan.org/vlc/3.0.8/macosx/vlc-3.0.8.dmg 
  #Need to mount and install the dmg file:
  #http://commandlinemac.blogspot.com/2008/12/installing-dmg-application-from-command.html
  hdiutil mount vlc-3.0.8.dmg 
  echo "    Installing...  This might take a second!"
  cp -r /Volumes/VLC\ media\ player/VLC.app /Applicaions/.
  echo "    Cleaning up..."
  hdiutil unmount /Volumes/VLC\ media\ player
  echo "    VLC complete!\n"
fi

#First get the repo, git should be installed on OSX by default
echo "Working on VLC-Protocol association:"
git clone https://github.com/mortsnake/vlc-protocol.git /tmp/vlc-protocol

#CD into dir, run the build script.  This should compile successfully
cd /tmp/vlc-protocol/mac
echo "    Building..."
./build.sh 

#Copy app into Applications dir
echo "    Installing..."
cp -r /tmp/vlc-protocol/mac/VLC-protocol-app /Applications/MortIsMoe\ Streaming.app
echo "    VLC-Protocol Add-On Complete\n"

#Instruct user to complete some instructions
echo "In a second, your web browser will open up.  When a pop-up asking you to do something with the file type shows up, select 'always use'
echo "In Firefox, you might have to 'choose another application' and select 'VLC-protocol'.  Make sure to select 'remember my choice'
echo "Safari is dumb, like usual and might not work.  I would recommend using Chrome or Firefox in general, anyways."
echo "\nJust press enter if you don't want to download any new browsers, or if you already have another browser"
echo ""
echo "1) Download Firefox"
echo "2) Download Chrome"
echo "3) Don't download anything new (default)"

read -p "Make Choice or Press Enter To Do Nothing: " ANSWER

case "$ANSWER" in 
  [1]|[Ff]*)
    

#Open up a link in web browser to set this file type association
open -a /Applications/Firefox.app vlc://https://mortis.moe
