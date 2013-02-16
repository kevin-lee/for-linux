#!/bin/bash
##########################################################
## Simple script to back up mysql databases.            ##
## @author Lee, SeongHyun (Kevin)                       ##
## @veraion 0.0.1 (2012-05-02)                          ##
##########################################################
current_date=$(date +"%Y-%m-%d")

default_pwd=$PWD
target_dir=$default_pwd
if [ -n "$1" ]
then
    target_dir=$1
fi
echo "The backup files will be created in $target_dir directory."
echo

cd $target_dir

IGNORE_DBS="information_schema"

DBS="information_schema mysql db_name1 db_name2"


echo -n "Please enter password: "

stty -echo
read PASSWORD_FOR_DB
stty echo

for db in $DBS
do
  skipdb=-1
  if [ "$IGNORE_DBS" != "" ];
  then
    for i_db in $IGNORE_DBS
    do
      [ "$db" == "$i_db" ] && skipdb=1 || :
    done
  fi

  if [ "$skipdb" == "-1" ] ; then
    echo -e "\n"
    echo "Backing up $db..."
    echo "please wait..."
    mysqldump --opt -h localhost -u root -p$PASSWORD_FOR_DB $db > DB_BackUp_$db\_$current_date.sql
    echo "done"
    echo "Create checksum..."
    sha1sum DB_BackUp_$db\_$current_date.sql > DB_BackUp_$db\_$current_date.sql.sha1
    echo "done"
  fi
done
echo -e "\nCreate a tar.gz file..."
tar -czvf DB_BackUp_All_DB_$current_date.tar.gz DB_BackUp_*_$current_date.sql*

echo ""
echo "All the specified databases have been backed up."
exit
