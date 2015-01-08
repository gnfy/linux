#!/bin/bash
tbl=$1
uname=root
pwd=root
host=127.0.0.1
port=3306
fromdb=o2o
todb=pinzhen_ecstore
# 清空要替换的数据表
mysql -u"$uname" -p"$pwd" -h "$host" --port=$port -e "$todb.$tbl"

# 复制数据及结构
#mysqldump -u"$uname" -p"$pwd" -h "$host" --port=$port --add-drop-table --skip-lock-tables $db $tbl | mysql -u"$uname" -p"$pwd" -h "$host" --port=$port -C $todb

# 复制数据
mysqldump -u"$uname" -p"$pwd" -h "$host" --port=$port --skip-lock-tables -tc $db $tbl | mysql -u"$uname" -p"$pwd" -h "$host" --port=$port -C $todb
