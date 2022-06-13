#!/usr/bin/env bash

echo "CS537 SU22 Project 1 Sample Tester"
echo "Author: Leping Li"
echo "---------------------------------"

UNAME_S=$(uname -s)
MY_CC=gcc
echo "[Environment]"
echo OS: "$UNAME_S"
echo Compiler: "$MY_CC"
echo "---------------------------------"

echo "[Execution]"
"$MY_CC" -g my-look.c -o my-look -Wall -Werror
rm -rf test_output
mkdir test_output

argv=(1 abandon a59 gn 123qwe gnus)
counter=0
for f in test_input/*.txt
do
  [[ -e "$f" ]] || break
  filename=$(basename "$f")
  filenameWithoutExt="${filename%.*}"
  echo "Running $filenameWithoutExt"
  echo "./my-look -f $f ${argv[$counter]} > test_output/$filename"
  ./my-look -f $f ${argv[$counter]} > test_output/$filename
  ((counter=counter+1))
done
rm -rf my-look
echo "---------------------------------"
echo "[Check]"
expected_out=1
for f in expected_output/*.txt
do
  [[ -e "$f" ]] || break
  filename=$(basename "$f")
  filenameWithoutExt="${filename%.*}"
  echo "Checking $filenameWithoutExt"
  out1=$(diff "$f" test_output/"$filename")
  out=$(echo "$out1" | wc -l)
  if [ "$out" = "$expected_out" ]; then
    echo "$filenameWithoutExt passed"
  else
    echo "$out1"
  fi
done
echo "---------------------------------"
echo "Finished"
