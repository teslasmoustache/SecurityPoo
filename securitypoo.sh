#!/bin/bash

###
# The purpose of this program is mostly comical. While it might end up being useful to someone, it definitely should not
# be relied upon for security purposes, or protection of anyone's property. It's a joke. And a pretty badly written script.
#
# The idea is that if you are in a public place, and you need to go to the bathroom, but are worried that someone will 
# steal your laptop if you leave it alone, you can run this program and your webcam will start broadcasting to an address you
# can get to on your phone.
###

echo "Welcome to SecurityPoo.
   (   )
  (   ) (
   ) _   )
    ( \_
  _(_\ \)__
 (____\___))   
For really shitty security."

### show LAN IP address ###
echo "your webcam should be visible at http://$(ifconfig wlp7s0 | grep 'inet addr:' | grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'):8082/stream.wmv"
echo "open that address in VLC on your phone. A QR code has been generated and should be displayed on your desktop. If not, you can find it at /tmp/stream.png"
echo "Hit Ctrl+C to activate the stream."

### create a QR code and open it. ###
qrencode -o /tmp/stream.png http://$(ifconfig wlp7s0 | grep 'inet addr:' | grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'):8082/stream.wmv && display /tmp/stream.png

echo "You can go take a dump now. Watch your phone to make sure no one touches your stuff." 
cvlc --quiet v4l2:// :v4l2-vdev="/dev/video0" --sout '#transcode{vcodec=x264{keyint=60,idrint=2},vcodec=h264,vb=400,width=368,heigh=208,acodec=mp4a,ab=32 ,channels=2,samplerate=22100}:duplicate{dst=std{access=http{mime=video/x-ms-wmv},mux=asf,dst=:8082/stream.wmv}}' --no-sout-audio
