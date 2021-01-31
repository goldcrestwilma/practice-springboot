#!/bin/bash

REPOSITORY=/home/ec2-user/app/step1
PROJECT_NAME=springboot-with-AWS

cd $REPOSITORY/$PROJECT_NAME/

echo "> Git Pull"

git pull

echo "> Start Build"

./gradlew build

echo "> Move step1 directory"

cd $REPOSITORY

echo "> Copy Build File"

cp $REPOSITORY/$PROJECT_NAME/build/libs/*.jar $REPOSITORY/

echo "> Check Application Pid"

CURRENT_PID=$(pgrep -f practice-springboot*.jar  | awk '{print $1}')

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

chmod +x $JAR_NAME

nohup java -jar \
    -Dspring.config.location=classpath:/application.properties,classpath:/application-real.properties,/home/ec2-user/app/application-oauth.properties,/home/ec2-user/app/application-real-db.properties \
    -Dspring.profiles.active=real \
    $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &

