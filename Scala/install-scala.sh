#!/bin/sh
###############################################
## Script to install Scala and SBT           ##
##                                           ##
## @author Lee, SeongHyun (Kevin)            ##
## @veraion 0.0.1 (2015-03-22)               ##
##                                           ##
## http://lckymn.com                         ##
###############################################

SCALA_VERSION="2.11.7"
SBT_VERSION="0.13.8"

# sudo apt-get remove scala-library scala

TMP_DIR="/tmp/scala-install-tmp-`date +%s`"

echo "mkdir -p $TMP_DIR"
mkdir -p "$TMP_DIR"
echo "cd $TMP_DIR"
cd "$TMP_DIR"
echo ""
echo "Install Scala"
echo ""
echo "wget http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb"
wget "http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb"
echo ""
echo "sudo apt-get update "
sudo apt-get update 
echo ""
echo "sudo dpkg -i scala-$SCALA_VERSION.deb "
sudo dpkg -i "scala-$SCALA_VERSION.deb" 

echo ""
echo "Scala installation: Done"
echo ""

echo "Install SBT"
echo "wget http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb "
wget "http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb"
echo "sudo dpkg -i sbt-$SBT_VERSION.deb "
sudo dpkg -i "sbt-$SBT_VERSION.deb"
echo ""
echo "SBT installation: Done"
echo ""

echo ""
echo "Remove the temporary directory."
echo "rm -R $TMP_DIR"
rm -R "$TMP_DIR"
echo ""
