#!/bin/bash

mkdir organised
for line in `cat mock_grading/roll_list` ;  do
        cd organised
        mkdir $line
        cd $line
        for var in `ls ../../mock_grading/submissions/$line*`; do
	b=basename $var
	ln -sr $var $b
       done
		
        cd ..
done  