#!/bin/sh

#get first arg
PASSWORD=$1

#initial values as contidions for password
HAVE_NUM=0
HAVE_UPPER_CHAR=0
HAVE_LOWER_CHAR=0

#len of first arg
COUNT=${#PASSWORD}
if [ "$COUNT" -lt "10" ];then echo "$(tput setaf 1)Password need to be at least 10 chars"; exit 1;fi

#iteration over password
for (( i=0; i<$COUNT; i++ ));do
        CHAR="${PASSWORD:$i:1}"
        if [[ "$CHAR" =~ [0-9] ]];then HAVE_NUM=1;fi
        if [[ "$CHAR" =~ [[:lower:]] ]];then HAVE_LOWER_CHAR=1;fi
        if [[ "$CHAR" =~ [[:upper:]] ]];then HAVE_UPPER_CHAR=1;fi
done

#Exit if conditions on match
if [ "$HAVE_NUM" -eq "0" ];then echo "$(tput setaf 1)Weak Password Should include a number.";exit 1;fi
if [ "$HAVE_UPPER_CHAR" -eq "0" ];then echo "$(tput setaf 1)Weak Password Should include a upper case letter.";exit 1;fi
if [ "$HAVE_LOWER_CHAR" -eq "0" ];then echo "$(tput setaf 1)Weak Password Should include a lower case letter.";exit 1;fi

echo "$(tput setaf 2)This is an awesome password!"
exit 0
