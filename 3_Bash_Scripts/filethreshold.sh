#!/bin/bash
file_usage_threshold=10
rm -rf file_sys_info.txt
df -ph |grep -VE "Filesystem|tmpfs|none" | while read line
do
   file_name=$(echo $line | awk '{ print $1 }')
   file_usage=$(echo $line |awk '{ print $5}' |sed 's/%//g')
   echo "file sys name: $file_name, file sys usage: $file_usage"
   if [$file_usage -gt $file_usage_threshold ]
   then
     echo "$file_name: $file_usage" >> file_sys_info.txt
   fi
done

cont=$(cat file_sys_info.txt | wc -l)
if [$cont -gt 0 ]
then
    echo "Some file systems usage is more than threshold"
    echo -e "Subject:Alert\n\n $(cat file_sys_info.txt)\n" | sendmail avardhineni3@gmail.com