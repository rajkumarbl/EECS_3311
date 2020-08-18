#!/bin/sh

student=./tictactoe/tests/acceptance/student
instructor=./tictactoe/tests/acceptance/instructor
s_results=./tictac_tests/student
i_results=./tictac_tests/instructor

mkdir -p $s_results
mkdir -p $i_results

for i in "$instructor"/*.txt
do
  ./tictactoe/EIFGENs/tictac/W_code/tictac -b $i > $i_results/actual.$(basename $i)
  ./oracle.exe -b $i > $i_results/expected.$(basename $i)
  diff $i_results/expected.$(basename $i) $i_results/actual.$(basename $i)
done

for i in $student/*.txt
do
  ./tictactoe/EIFGENs/tictac/W_code/tictac -b $i > $s_results/actual.$(basename $i)
  ./oracle.exe -b $i > $s_results/expected.$(basename $i)
  diff $s_results/expected.$(basename $i) $s_results/actual.$(basename $i)
done

