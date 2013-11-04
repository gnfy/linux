#!/bin/sh
:<<EOF
/**
 * ********************************************
 * Description   : less 编译并更新相关的页面
 * Filename      : lessc_file.sh
 * Create time   : 2013-07-15 14:14:21
 * Last modified : 2013-07-15 14:17:34
 * License       : MIT, GPL
 * ********************************************
 */
EOF

csspath='/root/wwwroot/to8to/css/wap/'

arg=$1

if [ -z "$arg" ];then
    echo 'not less file'
    exit 0
fi

filename=`basename $arg`
cssfilename=${filename%.*}.css
cssfile=${csspath}${cssfilename}

# 编译less
lessc $arg --yui-compress > $cssfile

if [ -f $cssfile ]; then

    echo $arg '=>' $cssfile OK

    # 更新css相关页面
    version=`date +%s`
    str=`grep -r "${cssfilename}" ./* --exclude-dir='.svn' | awk -F': ' '{print $1}'`;
    for i in $str;do
        sed -i "s/${filename%.*}\.css.*\"/${cssfilename}?v=${version}\"/g" $i
        echo $i css version update
    done

else
    echo $arg '=>' $cssfile FALSE
fi
