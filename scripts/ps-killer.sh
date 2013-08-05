#!/bin/bash
#############################################
## Simple script to kill processes         ##
##                                         ##
## @author Lee, SeongHyun (Kevin)          ##
## @veraion 0.0.1 (2013-02-19)             ##
##                                         ##
## http://lckymn.com                       ##
#############################################

THIS_SCRIPT_NAME="$(basename $0)"

LINES1="----------------------------------------------------------"
LINES2="=========================================================="

if [ -n "$1" ]
  then
  RESULT="`ps aux | egrep -vw 'egrep|'$0 | egrep $1 | awk '{ print $2"\t"substr($0, index($0, $11)); }'`"

if [ -n "$RESULT" ]
  then
    echo -e "$LINES2\n### PROCESS LIST ###\n$LINES1"
    echo "$RESULT"
    echo $LINES2
    echo "Kill (all: a / one by one: o / cancel: c)"
    typeset -l ANSWER
    read ANSWER
    if [[ "$ANSWER" == "a" || "$ANSWER" == "all" ]]
      then
      kill -9 `echo -e "$RESULT" | awk '{ print $1; }'`
      echo "killing all of the following process(es) has been done."
      echo -e "$RESULT"
    elif [[ "$ANSWER" == "o" || "$ANSWER" == "one" ]]
      then
        TMP_IFS=$IFS
        IFS=$'\n'
        for EACH in $RESULT
          do
          echo -e "\n$LINES1\n$EACH"
          echo "Kill it? (yes: y/no: n)"
          read ANSWER
          if [[ "$ANSWER" == "y" || "$ANSWER" == "yes" ]]
            then
            kill -9 `echo -e "$EACH" | awk '{ print $1; }'`
            echo "Killing \"$EACH\": Done."
          else
            echo "Ignore killing \"$EACH\""
          fi
          echo "$LINES1"
        done
        IFS=$TMP_IFS

        echo "There is no more process to be killed."
    else
      echo "$LINES2"
      echo "Killing the following process(es) has been cancelled."
      echo "$LINES1"
      echo -e "$RESULT"
      echo "$LINES1"
    fi
  else
    echo "No matching process with the given keyword ('$1') is found."
  fi
else
  echo "Please enter a process name."
  echo "e.g.) to kill a flash player"
  echo "$THIS_SCRIPT_NAME flash"
fi

exit
