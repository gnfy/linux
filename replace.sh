#!/bin/bash
find_to=$1
replace_to=$2
_find=${find_to//\//\\/}
_replace=${replace_to//\//\\/}
grep -r "$find_to" ./* --exclude-dir='.svn' | awk -F':' '{print $1}' | xargs sed -i "s/$_find/$_replace/g"
