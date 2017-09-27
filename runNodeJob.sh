#!/bin/bash

if [ $# -eq 0 ];  then
  echo "Sem argumento"
  exit 1
fi


filename=$(basename $1)
jobname=${filename%.*}

projectpath=`pwd`
logpath=log\/$jobname

mkdir -p $projectpath\/$logpath
logfile=$projectpath\/$logpath\/$jobname-`date -u +"%Y-%m-%d-T%H-%M-%S"`\.log


echo "JOB $jobname - `date` - START" | tee -a $logfile
echo "" | tee -a $logfile

node $1 2>&1 | tee -a $logfile

echo "" | tee -a $logfile
echo "JOB $jobname - `date` - END" | tee -a $logfile

gzip $logfile
