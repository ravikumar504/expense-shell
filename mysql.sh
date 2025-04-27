#!/bin/bash

userid=$(id -u)

validate() 
{
    if [ $1 -ne 0 ]
    then 
        echo "$2.... failure"
    else 
        echo "$2.... success"
    fi
}

if [ $userid -ne 0 ]
then 
    echo "you must need root access to execute this script"
    exit 1
fi


dnf install mysql-server -y
validate $? "installing mysql"

systemctl enable mysqld
validate $? "enable mysql"



