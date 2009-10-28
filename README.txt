DESCRIPTION
===========

Browser-based augmented-reality castle destruction game.


REQUIRES
========

HARDWARE:
- A Flash-compatible webcam. For Linux, see: http://linux-uvc.berlios.de/#devices
- A printed copy of the marker.pdf

EXTERNAL:
- Flex 4.0.0.10485        http://opensource.adobe.com/wiki/display/flexsdk/Gumbo
- Flash Player 10.0.0     http://www.adobe.com/support/flashplayer/downloads.html#fp10

BUILT-IN:
- FLARManager v06         http://words.transmote.com/wp/flarmanager/
- FLARToolkit 2.72.0.0    http://www.libspark.org/wiki/saqoosha/FLARToolKit/en
- Papervision3D 2.1.920   http://code.google.com/p/papervision3d/
- WOW Engine 2 r21 alpha  http://code.google.com/p/wow-engine/

EXTRA BUILT-IN:
- AS3DS 1.04              http://code.google.com/p/as3ds/
- AS3Dmod 0.2             http://code.google.com/p/as3dmod/


INSTALL
=======

git clone git://github.com/zed9h/pseudosiege.git pseudosiege
cd pseudosiege

And to quickstart, open the swf in the web browser:

firefox PseudoSiege.swf


flex command-line compiler
--------------------------

Install Flex 4 with it's bin/ on the PATH,
or configure Makefile, for other paths.

wget -P /tmp/ http://fpdownload.adobe.com/pub/flex/sdk/builds/flex4/flex_sdk_4.0.0.10485_mpl.zip
# or get the open-source version at http://opensource.adobe.com/wiki/display/flexsdk/Downloads
mkdir /opt/flex
cd /opt/flex
unzip /tmp/flex_sdk_4.0.0.10485_mpl.zip
chmod +x bin/*                                            # set permission to run
sed -i 's/\r//g' `file bin/* | grep text | cut -d : -f 1` # remove bad line-ending


Add it to the system PATH:

echo 'export PATH=$PATH:/opt/flex/bin' > /etc/profile.d/adobe-flex.sh
chmod +x /etc/profile.d/adobe-flex.sh                     # enable it to run on startup
. /etc/profile.d/adobe-flex.sh



stand-alone flash player
------------------------

After that, install the stand-alone debug flash player 10
somewhere on the system's PATH:

wget -P /tmp/ http://download.macromedia.com/pub/flashplayer/updaters/10/flash_player_10_linux_dev.tar.gz
# or donwload linux debug version at http://www.adobe.com/support/flashplayer/downloads.html
cd /opt/flex/bin
tar xzOf /tmp/flash_player_10_linux_dev.tar.gz flash_player_10_linux_dev/standalone/debugger/flashplayer.tar.gz | tar xz


After that, you can debug with:
fdb PseudoSiege.swf

