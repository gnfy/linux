#!/bin/bash
:<<EOF
/**
 * ********************************************
 * Description   : less编译程序
 * Filename      : less_compile.sh
 * Create time   : 2014-12-29 17:15:31
 * Last modified : 2015-01-08 15:18:07
 * License       : MIT, GPL
 * ********************************************
 */
EOF

DIR=`dirname $0`

CSS_DIR="$DIR/../images"

# less模块前缀
mod_prefix='mod-'

#编译临时变量
tmp_arr=''

# css目录检测
if [ ! -d $CSS_DIR ]; then
    mkdir -p $CSS_DIR
fi

# 编译配置
compile_ini="$DIR/compile.ini"
if [ ! -f $compile_ini ];then
    touch $compile_ini
fi

# 开始编译
function compileStart() {

    for filename in `ls $DIR | grep .less`
    do
        if [ -f "$DIR/$filename" ];then
            ext=${filename##*.}
            if [ $ext = 'less' ];then
                ftime=`stat -c %Y $DIR/$filename`
                f_last_time=`sed -n "/^$filename/p" $compile_ini | awk '{print $2}'`
                is_compile=1
                if [ $f_last_time  ]; then
                    is_compile=0
                    # 文件个性时间有变动时，则需要编译
                    if [ $ftime -ne $f_last_time ]; then
                        is_compile=1
                    fi
                fi
                if [ $is_compile -eq 1 ]; then
                    fn=${filename%.*}
                    prefix=${fn:0:4}
                    if [ $prefix != $mod_prefix ]; then
                        needCompileFile $filename
                    else
                        modNeedCompileFile $fn
                    fi
                fi
            fi
        fi
    done
    
    # 编译
    compileFile
}

# 需要编译的文件
function needCompileFile() {
    is_find=0
    for i in $tmp_arr
    do
        if [ $i == $1 ]; then
            is_find=1
        fi
    done
    if [ $is_find -eq 0 ];then
        tmp_arr="$tmp_arr $1"
    fi
}

# 需要编译的模块文件
function modNeedCompileFile() {
    for filename in `ls $DIR | grep .less | grep -v $mod_prefix`
    do
        find_str=`sed -n "/$1/p" $DIR/$filename`
        if [ "$find_str" ]; then
            needCompileFile $filename
        fi
    done
    # 记录日志
    filename=$1.less
    ftime=`stat -c %Y $DIR/$filename`
    f_last_time=`sed -n "/^$filename/p" $compile_ini | awk '{print $2}'`
    if [ $f_last_time  ]; then
        if [ $ftime -ne $f_last_time ]; then
            sed -i "s@^$filename.*@$filename $ftime@" $compile_ini
        fi
    else
        echo "$filename $ftime" >> $compile_ini
    fi
}

# 编译
function compileFile() {
    for i in $tmp_arr
    do
        fn=${i%.*}
        css_file=$CSS_DIR/${fn}.css
        lessc -x $i > $css_file
        if [ -f $css_file ]; then
            echo $i "=>" $css_file success
            # 记录日志
            ftime=`stat -c %Y $DIR/$i`
            f_last_time=`sed -n "/^$i/p" $compile_ini | awk '{print $2}'`
            if [ $f_last_time  ]; then
                if [ $ftime -ne $f_last_time ]; then
                    sed -i "s@^$i.*@$i $ftime@" $compile_ini
                fi
            else
                echo "$i $ftime" >> $compile_ini
            fi
        fi
    done
    # 清空编译变量
    tmp_arr=''
}

while :
do
compileStart
sleep 1
done
