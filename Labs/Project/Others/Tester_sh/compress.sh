#!/bin/sh
student=./tictactoe/tests/acceptance/student
echo -n "Enter output file name: "
read myoutfile

for i in $student/*.txt
do
  cat $i | while read line
     do
	echo "$line"
     done >> $myoutfile
done

./tictactoe/EIFGENs/tictac/W_code/tictac -b $myoutfile > actual.$(basename $i)
./old.oracle.exe -b $myoutfile > expected.$(basename $i)
  meld expected.$(basename $i) actual.$(basename $i)

