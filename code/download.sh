#!/bin/bash 
if  [ $# -ne 2 ];then 
	echo "Usage: bash download.sh <link to directory> <cut-dirs argument>"
	exit 1
else 
	wget -q -r -nH -np --cut-dirs=$2 --reject mp4,pdf,png,html,php,tmp,jpg $1 
	dir_name=$(basename $1)
	mv $dir_name mock_grading
fi

