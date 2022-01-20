#!/bin/sh
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
  echo $output
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )
  if [ $usep -ge 60 -a $usep -lt 80 ]; then
    echo "Warning,you're out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" 

  elif [ $usep -ge  80 ]; then
    echo "Critical,you're out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" 
  else
    echo "None of the given disk space limit's have been reached"
  fi
done
