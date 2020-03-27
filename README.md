# Notice
This project seemed dead, but I couldn't have imagined things to change.  I had already created a script for windows for this same thing, so I'm glad I don't have to do it for Mac too because this looks hard.

During my compilation and installation I found a few errors/warnings that pop up due to updates in Cocoa (I think that's what has been upgraded) so I fixed them, and confirm that this works as of today.

I also automated the install process.  

### Automatic Install
Just download the 'mim.sh' file, change permissions, and run it.  It will grab all the files from this forked repo (that is different from the original repo in just a few ways, which I will try to suggest merging to help other people when they come across the other repo first.

### Firefox
To get this working in Firefox, you have to open `about:config`, right click and
add a boolean with the name `network.protocol-handler.expose.vlc` set to `false`.
