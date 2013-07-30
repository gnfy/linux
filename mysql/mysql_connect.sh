#!/bin/sh
param="$1"
password="$2"
uh=`echo $param | awk -F':' '{print $1}'`
p=`echo $param | awk -F':' '{print $2}'`
username=`echo $uh | awk -F'@' '{print $1}'`
h=`echo $uh | awk -F'@' '{print $2}'`

if [ -z "$password" ] ; then
    echo -n "password: " ; stty -echo ; read password; stty echo; echo
fi

if [ -z "$h" ] ; then
    h="127.0.0.1"
fi

if [ -z "$p" ] ; then
    p="3306"
fi

mysql -u $username -p"$password" -h $h --port=$p
