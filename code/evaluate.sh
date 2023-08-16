#!/bin/bash

cd organised

for line in `cat ../mock_grading/roll_list` ;  do
	cd $line
                                                   
	for any in *;                               
		do                        
		if [ $any = *.cpp ]                                                            
		then                                    
			g++ $any -o executable 2> /dev/null                                        
		fi 
	done
	cd ..                                                                               
done

for line in `cat ../mock_grading/roll_list` ;  do
	cd $line

	mkdir student_outputs
	for any in ../../mock_grading/inputs/*;
		do
		nj=$(basename $any .in)
		touch student_outputs/$nj.out
		if [[ -f "executable" ]];then
		timeout 5 ./executable < $any > student_outputs/$nj.out 2> \/dev\/null | cat 
	done
	cd ..
done 

for line in `cat ../mock_grading/roll_list` ;  do
	cd $line

	let "marks= 0"
	for any in ../../mock_grading/outputs/*;
		do
		nj=$(basename $any .out)
		if  cmp -s "$any" "student_outputs/$nj.out" ;                               
		then 
			let "marks= $marks + 1"                                                   
		fi
	done
	=$(basename $j /)
	echo "$j,$marks" >> ../../unsorted_marksheet.csv                                  
	echo "$marks" >> ../../unsorted_distribution.txt                                  
	cd ..
done

cd ../

sort -r unsorted_distribution.txt > distribution.txt                                  
rm unsorted_distribution.txt                                                         

sort -t"," -r -k2 unsorted_marksheet.csv > marksheet.csv
rm unsorted_marksheet.csv                                                             