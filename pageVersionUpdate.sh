#!/bin/bash
:<<BLOCK
/**
 * ********************************************
 * Description   : 更新页面版本脚本
 * Filename      : pageVersionUpdate.sh
 * Create time   : 2011-12-19 18:09:05
 * Last modified : 2011-12-19 18:12:55
 * License       : MIT, GPL
 * ********************************************
 */
BLOCK
PAGE_ARR=(Index UserCenter SetHelp)
echo '请选择要更新版本的页面文件'
index=1
for file in "${PAGE_ARR[@]}"; do
    echo $index) $file.html
done
NUM=$(($1-1))
TIME=`date +%F\ %T`
MAX_NUM=${#PAGE_ARR[@]}
if [ $NUM -ge 0 ] ;then
    if [ $NUM -ge $MAX_NUM ] ;then
        for file in "${PAGE_ARR[@]}" ;do
            echo $file.html 'page version update'
            sed -i "s/\(var ${file}Version\s*=\).*/\1 '${TIME}'/g" ../${file}.html
            echo `sed -n "/var ${file}Version/p" ../${file}.html`
        done
    else
        echo ${PAGE_ARR[$NUM]}.html 'page version update'
        sed -i "s/\(var ${PAGE_ARR[$NUM]}Version\s*=\).*/\1 '${TIME}'/g" ../${PAGE_ARR[$NUM]}.html
        echo `sed -n "/var ${PAGE_ARR[$NUM]}Version/p" ../${PAGE_ARR[$NUM]}.html`
    fi
fi
