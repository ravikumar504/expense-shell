#!/bin/bash

userid=$(id -u)

validate() 
{
    if [ $1 -ne 0 ]
    then 
        echo "$2.... failure"
        exit 1
    else 
        echo "$2.... success"
    fi
}

if [ $userid -ne 0 ]
then 
    echo "you must need root access to execute this script"
    exit 1
fi

dnf install nginx -y 
validate $? "installing nginx"

systemctl enable nginx
validate $? "enable nginx"

systemctl start nginx
validate $? "start nginx"

rm -rf /usr/share/nginx/html/*
validate $? 'removing code'

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip
validate $? "downloading code"

cd /usr/share/nginx/html

unzip /tmp/frontend.zip
validate $? "unzip code"

cp /home/ec2-user/expense-shell/expense.conf /etc/nginx/default.d/expense.conf
validate $? "copy conf file"

systemctl restart nginx
validate $? "restart nginx"