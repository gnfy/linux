#!/bin/bash
:<<BLOCK
/**
 * ********************************************
 * Description   : 页面版本控制脚本
 * Filename      : page.sh
 * Create time   : 2011-12-20 13:41:18
 * Last modified : 2011-12-20 13:41:18
 * License       : MIT, GPL
 * ********************************************
 */
BLOCK
page_arr=(Index UserCenter SetHelp)
echo '请选择要更新版本的页面文件'
index=1
for file in "${page_arr[@]}"; do
    echo "  $index $file.html"
    ((index++))
done
echo '  0 全部更新'
echo '    其它键返回上级'
read -p '请输入对应的字符: ' num
reg=`echo $num | awk '/^[0-9]*$/{print $0}'`
if [ $reg ];then
    time=`date +%F\ %T`
    max_num=${#page_arr[@]}
    if [ $num -eq 0 ] ;then
        for file in "${page_arr[@]}" ;do 
            echo $file.html 'page version update'
            sed -i "s/\(var ${file}Version\s*=\).*/\1 '${time}'/g" ../${file}.html
            echo `sed -n "/var ${file}Version/p" ../${file}.html`
        done
    elif [ $num -gt 0 -a $num -le $max_num ];then
        num=$(($num-1))
        echo ${page_arr[$num]}.html 'page version update'
        sed -i "s/\(var ${page_arr[$num]}Version\s*=\).*/\1 '${time}'/g" ../${page_arr[$num]}.html
        echo `sed -n "/var ${page_arr[$num]}Version/p" ../${page_arr[$num]}.html`
        ./page.sh
        exit
    fi
else
    ./update.sh
    exit
fi
