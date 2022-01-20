#!bin/bash
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
  echo $output
  percentage=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )

  #elseif condition to check disk space percentage is greater than 60
  if [ $percentage -ge 60 -a $percentage -lt 80 ]; then 
    echo "Warning,you'll be out of space soon \"$partition ($percentage%)\" on $(hostname -i)" #display's 'WARNING' message with percentage,partition of disk and its IP ADDRESS 
  
  elif [ $percentage -ge  80 ]; then
    echo "Critical,you'll be out of space soon \"$partition ($percentage%)\" on $(hostname -i)" #display's 'CRITICAL' message with percentage,partition of disk and its IP ADDRESS
  else
    echo "Stable amount of disk space is present on $(hostname -i) address"
  fi
done
