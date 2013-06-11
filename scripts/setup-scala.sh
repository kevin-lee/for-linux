#!/bin/bash
#############################################
## Script                                  ##
## to install / reinstall / remove Scala   ##
##                                         ##
## @author Lee, SeongHyun (Kevin)          ##
## @veraion 0.0.1 (2013-06-11)             ##
##                                         ##
## http://lckymn.com                       ##
#############################################

THIS_SCRIPT_NAME="$(basename $0)"

if [ $EUID != 0 ]
  then
  echo "You must run this script with a super user privilege."
  echo -e "Try \n$ sudo $THIS_SCRIPT_NAME "
  exit
fi

LINES1="-------------------------------------------------------------------------------"
LINES2="==============================================================================="

USR_BIN="/usr/bin"

USR_SHARE="/usr/share"
USR_SHARE_SCALA="$USR_SHARE/scala"
USR_SHARE_SCALA_BIN="$USR_SHARE_SCALA/bin"

USR_SHARE_BIN_FSC="$USR_SHARE_SCALA_BIN/fsc"
USR_BIN_FSC="$USR_BIN/fsc"

USR_SHARE_BIN_SCALA="$USR_SHARE_SCALA_BIN/scala"
USR_BIN_SCALA="$USR_BIN/scala"

USR_SHARE_BIN_SCALAC="$USR_SHARE_SCALA_BIN/scalac"
USR_BIN_SCALAC="$USR_BIN/scalac"

USR_SHARE_BIN_SCALADOC="$USR_SHARE_SCALA_BIN/scaladoc"
USR_BIN_SCALADOC="$USR_BIN/scaladoc"

USR_SHARE_BIN_SCALAP="$USR_SHARE_SCALA_BIN/scalap"
USR_BIN_SCALAP="$USR_BIN/scalap"

typeset -l ANSWER

take_answer() {
  read ANSWER
  while [[ "$ANSWER" != "yes" && "$ANSWER" != "no" && "$ANSWER" != "y" && "$ANSWER" != "n" ]]
  do
    echo ""
    echo "Please choose either 'yes' or 'no' ('y' or 'n') without quotes"
    echo -e "$1"
    echo "Would you like to proceed? (yes/no | y/n)"
    read ANSWER
  done
}

remove_scala() {
  echo "[WARNING!!!] Uninstalling Scala will remove the existing Scala "
  echo "from $USR_SHARE_SCALA and remove all the link to scala executable from $USR_BIN."
  echo "Would you like to uninstall scala? (y/n | yes/no)"
  take_answer "It will remove the existing Scala from $USR_SHARE_SCALA and remove all the links to scala executable from $USR_BIN."
  if [[ "$ANSWER" == "yes" || "$ANSWER" == "y" ]]
    then
    echo "$LINES1"
    echo "Remove existing scala directory ($USR_SHARE_SCALA)."
    if [[ ! -d "$USR_SHARE_SCALA" && ! -L "$USR_SHARE_SCALA" ]]
      then
      echo "$USR_SHARE_SCALA does not exist so skip it."
    else
      echo "rm -R $USR_SHARE_SCALA "
      rm -R $USR_SHARE_SCALA 
      echo "Done."
    fi
    echo "$LINES1"
    echo "Remove existing scala executable links from $USR_BIN."
    if [[ ! -f "$USR_BIN_FSC" && ! -L "$USR_BIN_FSC" ]]
      then
      echo "$USR_BIN_FSC does not exist so skip it."
    else
      echo "rm $USR_BIN_FSC" 
      rm "$USR_BIN_FSC" 
    fi
    
    if [[ ! -f "$USR_BIN_SCALA" &&  ! -L "$USR_BIN_SCALA" ]]
      then
      echo "$USR_BIN_SCALA does not exist so skip it."
    else
      echo "rm $USR_BIN_SCALA" 
      rm "$USR_BIN_SCALA" 
    fi

    if [[ ! -f "$USR_BIN_SCALAC" && ! -L "$USR_BIN_SCALAC" ]]
      then
      echo "$USR_BIN_SCALAC does not exist so skip it."
    else
      echo "rm $USR_BIN_SCALAC" 
      rm "$USR_BIN_SCALAC" 
    fi

    if [[ ! -f "$USR_BIN_SCALADOC" && ! -L "$USR_BIN_SCALADOC" ]]
      then
      echo "$USR_BIN_SCALADOC does not exist so skip it."
    else
      echo "rm $USR_BIN_SCALADOC" 
      rm "$USR_BIN_SCALADOC" 
    fi
    
    if [[ ! -f "$USR_BIN_SCALAP" && ! -L "$USR_BIN_SCALAP" ]]
      then
      echo "$USR_BIN_SCALAP does not exist so skip it."
    else
      echo "rm $USR_BIN_SCALAP" 
      rm "$USR_BIN_SCALAP" 
    fi
    echo "Done."
    echo "$LINES1"
  else
    echo "$LINES1"
    echo "Uninstalling Scala has been cancelled. Bye~!"
    echo "$LINES1"
    exit
  fi
}

NEW_SCALA_PATH=""

get_new_scala_path() {
  if [ -n "$1" ]
    then
    NEW_SCALA_PATH="$1"

    if [[ "$NEW_SCALA_PATH" != /* ]]
      then
      NEW_SCALA_PATH="`pwd`/$NEW_SCALA_PATH"
    fi
  else
    NEW_SCALA_PATH=""
  fi
}

assert_dir_or_link_exists() {
  if [[ ! -d "$1" && ! -L "$1"  ]]
    then
    DIR="$2 directory"
    if [ ! -n "$2" ]
      then
      DIR="directory"
    fi
    echo "The $DIR, $1, does not exist."
    exit 1
  fi
}

install_scala() {
  if [ -n "$1" ]
    then
    get_new_scala_path "$1"
    echo "$LINES2"

    assert_dir_or_link_exists "$NEW_SCALA_PATH" "scala"

    if [[ -d "$USR_SHARE_SCALA" || -L "$USR_SHARE_SCALA" ]]
      then
      echo "$USR_SHARE_SCALA already exists."
      echo "Please remove the existing one first "
      echo "or run reinstall instead of install"
      echo "e.g.) $THIS_SCRIPT_NAME reinstall SCALA_DIR"
      echo "$LINES1"
      echo "Installing $NEW_SCALA_PATH has been cancelled. Bye~!"
      echo "$LINES1"
      exit
    fi

    echo "Installing Scala: It will copy "
    echo "$NEW_SCALA_PATH"
    echo " to "
    echo "$USR_SHARE_SCALA"
    echo "Would you like to proceed? (y/n | yes/no)"
    take_answer "Installing Scala: It will copy \n$NEW_SCALA_PATH\n to \n$USR_SHARE_SCALA"

    if [[ "$ANSWER" == "no" || "$ANSWER" == "n" ]]
      then
      echo "$LINES1"
      echo "Installing $NEW_SCALA_PATH has been cancelled. Bye~!"
      echo "$LINES1"
      exit
    fi

    # install
    echo "$LINES1"
    echo "Copying $NEW_SCALA_PATH -> $USR_SHARE_SCALA"
    echo "cp -R $NEW_SCALA_PATH $USR_SHARE_SCALA " 
    cp -R "$NEW_SCALA_PATH" "$USR_SHARE_SCALA" 
    echo "Done."
    echo "$LINES1"

    echo "Creating symbolic link of scala executable files in bin dir if it doesn't exist."
    echo "$LINES1"
    if [[ -f "$USR_BIN_FSC" || -L "$USR_BIN_FSC" ]]
      then
      echo "$USR_BIN_FSC exists so skip it."
    else
      echo "ln -s $USR_SHARE_BIN_FSC" "$USR_BIN_FSC "
      ln -s "$USR_SHARE_BIN_FSC" "$USR_BIN_FSC" 
    fi

    if [[ -f "$USR_BIN_SCALA" || -L "$USR_BIN_SCALA" ]]
      then
      echo "$USR_BIN_SCALA exists so skip it."
    else
      echo "ln -s $USR_SHARE_BIN_SCALA" "$USR_BIN_SCALA"
      ln -s "$USR_SHARE_BIN_SCALA" "$USR_BIN_SCALA" 
    fi

    if [[ -f "$USR_BIN_SCALAC" || -L "$USR_BIN_SCALAC" ]]
      then
      echo "$USR_BIN_SCALAC exists so skip it."
    else
      echo "ln -s $USR_SHARE_BIN_SCALAC" "$USR_BIN_SCALAC "
      ln -s "$USR_SHARE_BIN_SCALAC" "$USR_BIN_SCALAC" 
    fi

    if [[ -f "$USR_BIN_SCALADOC" || -L "$USR_BIN_SCALADOC" ]]
      then
      echo "$USR_BIN_SCALADOC exists so skip it."
    else
      echo "ln -s $USR_SHARE_BIN_SCALADOC" "$USR_BIN_SCALADOC "
      ln -s "$USR_SHARE_BIN_SCALADOC" "$USR_BIN_SCALADOC" 
    fi

    if [[ -f "$USR_BIN_SCALAP" || -L "$USR_BIN_SCALAP" ]]
      then
      echo "$USR_BIN_SCALAP exists so skip it."
    else
      echo "ln -s $USR_SHARE_BIN_SCALAP" "$USR_BIN_SCALAP "
      ln -s "$USR_SHARE_BIN_SCALAP" "$USR_BIN_SCALAP" 
    fi
    echo "Done."
    echo "$LINES1"
    echo "You probably want to add \$SCALA_HOME to ~/.bashrc "
    echo "e.g.)"
    echo "export SCALA_HOME=$USR_SHARE_SCALA"
    echo "$LINES2"
  else
    echo "Please enter the scala directory name."
    echo "e.g.)"
    echo "$ $THIS_SCRIPT_NAME install scala-2.10.2 "
    exit 1
  fi
}


reinstall_scala() {
  if [ -n "$1" ]
    then
    get_new_scala_path "$1"
    echo "$LINES2"

    assert_dir_or_link_exists "$NEW_SCALA_PATH" "scala"

    if [[ -d "$USR_SHARE_SCALA" || -L "$USR_SHARE_SCALA" ]]
      then
      echo "$USR_SHARE_SCALA already exists."
      echo "Would you like to remove it (including executable links in $USR_BIN) "
      echo "and install the new one? (y/n | yes/no)"

      take_answer "It will remove the existing '$USR_SHARE_SCALA' directory and install '$NEW_SCALA_PATH'."

      if [[ "$ANSWER" == "yes" || "$ANSWER" == "y" ]]
        then
        echo "$LINES1"
        remove_scala
        echo "$LINES1"
      else
        echo "$LINES1"
        echo "Reinstalling $NEW_SCALA_PATH has been cancelled. Bye~!"
        echo "$LINES1"
        exit
      fi
    else
      echo "$LINES1"
      echo "$USR_SHARE_SCALA does not exist so skip uninstallation."
      echo "$LINES1"
    fi
    install_scala "$1"
  else
    echo "Please enter the scala directory name."
    echo "e.g.)"
    echo "$ $THIS_SCRIPT_NAME reinstall scala-2.10.2 "
    exit 1
  fi
}

case $1 in
  reinstall)
    reinstall_scala "$2"
  ;;
  install)
    install_scala "$2"
  ;;
  remove)
    remove_scala
  ;;
  *)
    echo "[ERROR] Unknown option: $1"
    echo "* Usage: "
    echo " * Installation: "
    echo "   $THIS_SCRIPT_NAME install NEW_SCALA_DIR "
    echo ""
    echo " * Reinstallation: "
    echo "   $THIS_SCRIPT_NAME reinstall NEW_SCALA_DIR "
    echo ""
    echo " * Uninstallation: "
    echo "   $THIS_SCRIPT_NAME remove "
  ;;
esac
exit
