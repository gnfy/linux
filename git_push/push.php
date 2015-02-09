<?php
$post   = $_POST;
$data	= json_decode($post['hook']);
if ( $data->password == '***' ) {
    ob_start();
    $uname = isset($data->push_data->user_name) ? $data->push_data->user_name : '';
    echo date('Y-m-d H:i:s').' '.$uname." 开始同步....\n";
    system('./sync/sync.sh');
    echo date('Y-m-d H:i:s').' '.$uname." 完成同步....\n";
    $out    = ob_get_contents();
    error_log($out, 3, '/alidata/www/git_push/push.log');
    ob_end_clean();
}
echo 1;
