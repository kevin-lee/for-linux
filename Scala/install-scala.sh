#!/bin/sh
###############################################
## Script to install Scala and SBT           ##
##                                           ##
## @author Lee, SeongHyun (Kevin)            ##
## @veraion 0.0.1 (2015-03-22)               ##
##                                           ##
## http://lckymn.com                         ##
###############################################

SCALA_VERSION="2.11.8"
SBT_VERSION="0.13.9"

# sudo apt-get remove scala-library scala

TMP_DIR="/tmp/scala-install-tmp-`date +%s`"

echo "mkdir -p $TMP_DIR"
mkdir -p "$TMP_DIR"
echo "cd $TMP_DIR"
cd "$TMP_DIR"
echo "============================="
echo "Download Scala"
echo "-----------------------------"
echo ""
echo "wget http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb"
wget "http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb"
echo ""
echo "-----------------------------"
echo "Downloading Scala: Done"
echo "============================="
echo ""
echo "============================="
echo "Download SBT"
echo "-----------------------------"
echo "wget http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb "
wget "http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb"
echo ""
echo "-----------------------------"
echo "Downloading SBT: Done"
echo "============================="
echo ""
echo "sudo apt-get update "
sudo apt-get update 
echo ""
echo "============================="
echo "Install Scala"
echo "-----------------------------"
echo ""
echo "sudo dpkg -i scala-$SCALA_VERSION.deb "
sudo dpkg -i "scala-$SCALA_VERSION.deb" 
echo ""
echo "-----------------------------"
echo "Scala installation: Done"
echo "============================="
echo ""
echo "============================="
echo "Install SBT"
echo "-----------------------------"
echo ""
echo "sudo dpkg -i sbt-$SBT_VERSION.deb "
sudo dpkg -i "sbt-$SBT_VERSION.deb"
echo ""
echo "-----------------------------"
echo "SBT installation: Done"
echo "============================="
echo ""

echo ""
echo "Remove the temporary directory."
echo "rm -R $TMP_DIR"
rm -R "$TMP_DIR"
echo ""
