#!/bin/sh
:<<EOF
/**
 * ********************************************
 * Description   : 服务检测脚本
 * Filename      : server.sh
 * Create time   : 2013-05-30 00:30:27
 * Last modified : 2013-05-30 00:39:54
 * License       : MIT, GPL
 * ********************************************
 */
EOF

# 启动程序路径
DAEMON=/opt/mysql/bin/mysqld_safe

# 进程名
PS='mysqld'

# 进程ID存放文件名称
PIDFILE=mysqld.pid

# 进程ID存放路径
PIDPATH=/opt/mysql/run

# 检测PID是否正常
checkPid() {

    PID=`pidof $PS`

    [ -e $PIDPATH/$PIDFILE ] && PID2=`cat $PIDPATH/$PIDFILE`

    # 有的服务可能会启动多个进程，循环判断主进程是否正常
    for i in $PID; do
        if [ "$i" = "$PID2" ]; then
            return 1
        fi  
    done
    return 0
}

# 是否正常运行,不正常运行，则尝试启动服务
isRunning() {

    checkPid

    STATUS=$?

    # 日志
    LOG=$PS-`date +%Y%m%d`.log

    if [ $STATUS -gt 0 ]; then
        echo `date +%F\ %T`" $PS is running...." >> $LOG
    else
        echo `date +%F\ %T`" $PS not running...." >> $LOG
        # 启动
        $DAEMON &
    fi
}

isRunning
