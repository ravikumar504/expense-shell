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

dnf module disable nodejs -y
validate $? "disabling nodejs"

dnf module enable nodejs:20 -y
validate $? "enabling nodejs"

dnf install nodejs -y 
validate $? "installing nodejs"

id expense

if [ $? -ne 0 ]
then
    useradd expense
    validate $? "adding user expense"
else
    echo "user already added"
fi


mkdir -p /app
validate $? "directory creating"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip
validate $? "downloading code"

cd /app

rm -rf /app/*
validate $? "removing files"

unzip /tmp/backend.zip
validate $? "unzipping the code"

npm install 
validate $? "installing dependencies"

cp backend.service /etc/systemd/system/backend.service

dnf install mysql -y
validate $? "installing mysql"

mysql -h 34.207.158.75 -uroot -pExpenseApp@1 < /app/schema/backend.sql
validate $? "schema loading"

systemctl daemon-reload
validate $? "daemon reload"

systemctl enable backend
validate $? "enabling backend "

systemctl restart backend
validate $? "restarting backend "
