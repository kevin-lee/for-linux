#!/bin/bash
###############################################
## Script to start / stop / restart Tomcat   ##
##                                           ##
## @author Lee, SeongHyun (Kevin)            ##
## @veraion 0.0.1 (2013-05-16)               ##
##                                           ##
## http://lckymn.com                         ##
###############################################

THIS_SCRIPT_NAME="$(basename $0)"

TOMCAT_HOME="/path/to/tomcat"

TOMCAT_SH="/etc/init.d/tomcat"

# If you have more than one Tomcat instance running, you probably want to use another keyword such as the home or bin directory of each Tomcat.
TOMCAT_PROCESS_KEYWORD="org.apache.catalina.startup.Bootstrap"
# TOMCAT_PROCESS_KEYWORD="$TOMCAT_HOME/bin/"


if [ ! -f "$TOMCAT_SH" ]
then
  echo -e "[ERROR] Tomcat start/stop script ('$TOMCAT_SH') does not exist!\n"
  exit
fi

if [ ! -n "$1" ]
then
  echo "[ERROR] No option is given."
  echo "* Available options are:"
  echo "start"
  echo "stop"
  echo "restart"
  echo ""
  echo "e.g.)"
  echo "$THIS_SCRIPT_NAME start "
  echo "$THIS_SCRIPT_NAME stop "
  echo "$THIS_SCRIPT_NAME restart "
  exit
fi

RESULT=""
checkProcess() {
  RESULT="`ps aux | egrep -vw 'egrep|'$0 | egrep $TOMCAT_PROCESS_KEYWORD`"
  return 0
}

stop() {
  checkProcess

  if [ -n "$RESULT" ]
  then
    $TOMCAT_SH stop

    echo -e "\nStopping Tomcat..."

    checkProcess
    RESULT=`echo $RESULT`
    while [ -n "$RESULT" ]
    do
      sleep 1
      checkProcess
      RESULT=`echo $RESULT`
    done

    echo -e "Tomcat has been stopped."
  else
    echo "Tomcat is not running. So skip stop process."
  fi
}

start() {

  checkProcess

  if [ -n "$RESULT" ]
  then
    echo "Tomcat is already running. So skip start process."
  else
    $TOMCAT_SH start  
    echo -e "\nStarting Tomcat..."
    echo "Done! check the Tomcat log to see if it has started properly."
  fi
}

restart() {
  START_TIME="`date +%s`"

  stop
  echo -e "Now start Tomcat again!\n"
  start

  END_TIME="`date +%s`"

  echo -e "It took $(($END_TIME - $START_TIME)) seconds.\n"
  echo -e "Restarting has been successfully done. Bye~!\n"
}


case $1 in
  restart)
    restart
  ;;
  stop)
    stop
  ;;
  start)
    start
  ;;
  *)
    echo "[ERROR] Unknown option: $1"
  ;;
esac
exit