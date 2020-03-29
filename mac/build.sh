#!/bin/bash -ex

#Compile App
mkdir -p VLC-protocol-app/Contents/MacOS
gcc -framework Cocoa -o VLC-protocol-app/Contents/MacOS/vlc-protocol vlc-protocol.m

#Add Icon File and Resource Directory 
mkdir VLC-protocol-App/Contents/Resources
curl -O https://mortis.moe/resources/siteicons/iconfile.icns
mv iconfile.icns VLC-protocol-App/Contents/Resources/iconfile.icns

curl -O https://raw.githubusercontent.com/mortsnake/vlc-protocol/master/mac/Info.plist
mv Info.plist VLC-protocol-App/Contents/.
