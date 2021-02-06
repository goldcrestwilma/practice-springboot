#!/bin/bash

REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=springboot-with-AWS

echo "> Copy Build File"

cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo "> Check Application Pid"

CURRENT_PID=$(pgrep -f practice-springboot  | awk '{print $1}')

echo "> Application Pid: $CURRENT_PID"

if [ -z "$CURRENT_PID" ]; then
        echo "The running application does not exist."
else
        echo "> kill -15 $CURRENT_PID"
        kill -15 $CURRENT_PID
        sleep 5
fi

echo "> Deploy new application"

JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> JAR Name: $JAR_NAME"

echo "> Add permission"

chmod +x $JAR_NAME

echo "> Run Application"

nohup java -jar \
    -Dspring.config.location=classpath:/application.properties,classpath:/application-real.properties,/home/ec2-user/app/application-oauth.properties,/home/ec2-user/app/application-real-db.properties \
    -Dspring.profiles.active=real \
    $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &