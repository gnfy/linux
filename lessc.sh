#!/bin/sh
:<<EOF
/**
 * ********************************************
 * Description   : 编译所有的less成为css
 * Filename      : lessc.sh
 * Create time   : 2013-07-15 14:15:02
 * Last modified : 2013-07-15 14:17:40
 * License       : MIT, GPL
 * ********************************************
 */
EOF

csspath='/root/wwwroot/to8to/css/wap/'

file=`find ./* -name '*.less' | grep -v 'mod-'`

for i in $file; do
    ~/lessc_file.sh $i
    #filename=`basename $i`
    #cssfile=${csspath}${filename%.*}.css
    #lessc $i --yui-compress > $cssfile
    #if [ -f $cssfile ]; then
    #    echo $i '=>' $cssfile OK
    #else
    #    echo $i '=>' $cssfile FALSE
    #fi
done;
