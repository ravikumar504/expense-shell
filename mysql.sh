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

systemctl start mysqld
validate $? "start mysql"

mysql -h 34.207.158.75 -u root -pExpenseApp@1 -e 'show databases;' 

if [ $? -ne 0 ]
then 
    echo "root pwd not setup" 
    mysql_secure_installation --set-root-pass ExpenseApp@1
    validate $? "root pwd setup"
else
    echo "root pwd already setup"
fi


