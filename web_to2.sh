#!/bin/bash
#ip="10.163.166.12"
#src="/mnt/www/"
#dst="/mnt/www/"
#/usr/local/bin/inotifywait -mrq -e create,delete,modify,move $src | while read line
#/usr/local/bin/unison -batch $src ssh://$ip/$dst

UNISON=`ps -ef |grep -v grep|grep -c inotifywait`
if [ ${UNISON} -lt 1 ]; then
ip="10.144.34.249"
src="/mnt/www/hc/"
dst="/mnt/www/hc/"
rsync_path="/root/rsync_include_path.ini"
/usr/local/bin/inotifywait -mrqe create,delete,modify,move $src | while read line
do
    file=`echo $line | awk '{print $3}'`
    path=`echo $line | awk '{print $1}'`
    ext=${file##*.}
    if [ $ext != 'swp' -a $ext != 'swx' -a $ext != 'txt~' ]; then
        if [ `echo $path | grep -E '/public/|/themes/'` ]; then
	        `echo $file >> /mnt/sync.log`
            #/usr/local/bin/unison -batch $src ssh://root@${ip}/${dst} -logfile=/mnt/unison.log
            /usr/local/bin/unison
        else
            grep_file=`cat $rsync_path | sed ':l;N;s/\n/|/;b l'`
            if [ `echo $path | grep -E "$grep_file"` ]; then
	            #`echo $file >> /mnt/sync_code.log`
                rsync -azrtopg --delete --include-from=$rsync_path --log-file='/mnt/sync_code.log' --exclude="/*" --exclude="*.swp" $src root@web2:$dst
            fi
        fi
    fi
done
fi
