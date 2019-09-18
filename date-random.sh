#!/bin/bash
mkdir /var/htdocs
#INTERVAL=$1
while : 
do
  /usr/bin/echo "date is : " `date` >> /var/htdocs/index.html
  /usr/bin/echo "RANDOM is : " `echo $RANDOM` >> /var/htdocs/index.html
  sleep $INTERVAL 
done
