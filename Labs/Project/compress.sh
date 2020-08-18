#!/bin/sh
student=./tracker-project/tests/acceptance/student
s_results=./tracker-project_tests/student

mkdir -p $s_results

echo -n "Enter output file name: "
read myoutfile

for i in $student/*.txt
do
  cat $i | while read line
     do
	echo "$line"
     done >> $s_results/$myoutfile
done

./tracker-project/EIFGENs/tracker/W_code/tracker -b $s_results/$myoutfile > $s_results/actual.$(basename $i)
./oracle.exe -b $s_results/$myoutfile > $s_results/expected.$(basename $i)
  meld $s_results/expected.$(basename $i) $s_results/actual.$(basename $i)

