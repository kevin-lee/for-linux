#!/bin/bash
###############################################
## Script to start / stop / restart Tomcat   ##
##                                           ##
## @author Lee, SeongHyun (Kevin)            ##
## @veraion 0.0.1 (2013-05-16)               ##
##                                           ##
## http://lckymn.com                         ##
###############################################

TOMCAT_HOME="/path/to/tomcat"

TOMCAT_SH="/etc/init.d/tomcat"

TOMCAT_PROCESS_KEYWORD="$TOMCAT_HOME/bin/"


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
  echo "$0 start "
  echo "$0 stop "
  echo "$0 restart "
  exit
fi

stop() {
  RESULT="`ps aux | egrep -vw 'egrep|'$0 | egrep $TOMCAT_PROCESS_KEYWORD`"

  if [ -n "$RESULT" ]
  then
    $TOMCAT_SH stop

    echo -e "\nStopping Tomcat..."

    # RESULT="`ps aux | egrep -vw 'egrep|tail|'$0 | egrep $TOMCAT_PROCESS_KEYWORD`"
    RESULT="`ps aux | egrep -vw 'egrep|'$0 | egrep $TOMCAT_PROCESS_KEYWORD`"
    RESULT=`echo $RESULT`
    while [ -n "$RESULT" ]
    do
      sleep 1
      # RESULT="`ps aux | egrep -vw 'egrep|tail|'$0 | egrep $TOMCAT_PROCESS_KEYWORD`"
      RESULT="`ps aux | egrep -vw 'egrep|'$0 | egrep $TOMCAT_PROCESS_KEYWORD`"
      RESULT=`echo $RESULT`
    done

    echo -e "Tomcat has been stopped."
  else
    echo "Tomcat is not running. So skip stop process."
  fi
}

start() {

  RESULT="`ps aux | egrep -vw 'egrep|'$0 | egrep $TOMCAT_PROCESS_KEYWORD`"

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