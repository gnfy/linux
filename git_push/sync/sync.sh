#!/bin/bash
cd /mnt/www/test && git pull;
rsync -vazrtopg --delete --exclude-from=/mnt/www/sync/exclude-file.ini /mnt/www/test/ /mnt/www/
