#!/usr/bin/env bash

# *****************************************
#
#      LineageOS Builder - Init Script
#
# *****************************************
#
# For Ubuntu 20.04 Only

user=${GIT_NAME:-Anonymous}
email=${GIT_EMAIL:-your-mail@example.com}

sudo=
[[ $EUID == 0 ]] || sudo=sudo
install="$sudo apt install -y"

# 0x00. Install the build packages
# https://wiki.lineageos.org/devices/umi/build/#install-the-build-packages
$sudo apt update && $sudo apt upgrade -y
$install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-gtk3-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python-is-python3

$install lib32ncurses5-dev

# 0x01. Install Android tools
export BIN_PATH=$HOME/.local/share/bin
mkdir -p $BIN_PATH && cd $BIN_PATH

## Android platform tools
curl -LO https://dl.google.com/android/repository/platform-tools-latest-linux.zip
unzip platform-tools-latest-linux.zip
mv platform-tools/* .

## repo
curl -LO https://storage.googleapis.com/git-repo-downloads/repo
chmod a+x repo

## clean up
rm platform-tools-latest-linux.zip
rm -r platform-tools

cd $HOME

## add bin path to PATH
echo "# set PATH so it includes user's private bin if it exists" > ~/.profile
echo "if [ -d $BIN_PATH ] ; then" >> ~/.profile
echo "    PATH=\"$BIN_PATH:$PATH\"" >> ~/.profile
echo 'fi' >> ~/.profile
. ~/.profile

# 0x02. Set up environment
echo "export USE_CCACHE=1" >> ~/.bashrc
echo "export CCACHE_EXEC=/usr/bin/ccache" >> ~/.bashrc
echo "ccache -M 50G" >> ~/.bashrc
echo "ccache -o compression=true" >> ~/.bashrc

git config --global user.name "$user"
git config --global user.email "$email"
