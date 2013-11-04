#!/bin/sh
param="$1"
password="$2"
tbl=`echo $param | awk -F'/' '{print $2}'`
param=`echo $param | awk -F'/' '{print $1}'`
uh=`echo $param | awk -F':' '{print $1}'`
p=`echo $param | awk -F':' '{print $2}'`
username=`echo $uh | awk -F'@' '{print $1}'`
h=`echo $uh | awk -F'@' '{print $2}'`

if [ -z "$password" ] ; then
    echo -n "password: " ; stty -echo ; read password; stty echo; echo
fi

if [ -z "$tbl" ] ; then
    read -p "请输入要导出的数据库名:" tbl
fi

filename="$tbl"-`date +%F`.sql

if [ -z "$h" ] ; then
    h="127.0.0.1"
fi

if [ -z "$p" ] ; then
    p="3306"
fi

mysqldump -u $username -p"$password" -h $h --port=$p --add-drop-table --skip-lock-tables $tbl > ./$filename

#mysql -u $username -p"$password" -h $h --port=$p
