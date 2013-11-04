#!/usr/bin/expect

spawn svn log -v -r 70

expect "*assword:" {send "wwke3lf\r"}

expect eof 

exit
