#!/bin/bash
from_server="$1"
to_server="$2"

db1=`echo $from_server | awk -F'/' '{print $2}'`
from_server=`echo $from_server | awk -F'/' '{print $1}'`
uh=`echo $from_server | awk -F':' '{print $1}'`
port1=`echo $from_server | awk -F':' '{print $2}'`
up1=`echo $uh | awk -F'@' '{print $1}'`
h1=`echo $uh | awk -F'@' '{print $2}'`
u1=`echo $up1 | awk -F'-p' '{print $1}'`
p1=`echo $up1 | awk -F'-p' '{print $2}'`

db2=`echo $to_server | awk -F'/' '{print $2}'`
to_server=`echo $to_server | awk -F'/' '{print $1}'`
uh=`echo $to_server | awk -F':' '{print $1}'`
port2=`echo $to_server | awk -F':' '{print $2}'`
up2=`echo $uh | awk -F'@' '{print $1}'`
h2=`echo $uh | awk -F'@' '{print $2}'`
u2=`echo $up2 | awk -F'-p' '{print $1}'`
p2=`echo $up2 | awk -F'-p' '{print $2}'`

#if [ -z "$password" ] ; then
#    echo -n "password: " ; stty -echo ; read password; stty echo; echo
#fi

param_error() {
   echo '用户-p密码@主机:端口/表名'
   exit
}

if [ -z "$h1" ] ; then
    echo '目标主机参数错误'
    param_error
fi

if [ -z "$h2" ] ; then
    h2="127.0.0.1"
fi

if [ -z "$port1" ] ; then
    port1="3306"
fi

if [ -z "$port2" ] ; then
    port2="3306"
fi

if [ -z "$db1" ] ; then
    read -p "请输入 $h1 上的数据库名:" db1
fi

if [ -z "$db2" ] ; then
    read -p "请输入 $h2 上的数据库名:" db2
fi


if [ -z "$p1" ] ; then
    echo -n "$h1 数据库密码: " ; stty -echo ; read p1; stty echo; echo
fi

if [ -z "$p2" ] ; then
    echo -n "$h2 数据库密码: " ; stty -echo ; read p2; stty echo; echo
fi

mysqldump -u $u1 -p'$p1' -h $h1 --port=$port1 --add-drop-table -c --skip-lock-tables $db1 | mysql -u $u2 -p'$p2' -h $h2 --port=$port2 -C $db2
