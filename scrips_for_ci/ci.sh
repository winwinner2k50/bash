#!/bin/bash
if [ "$1" = "1" ]
then
    rm temp_for_ci.txt
    exit 0
fi
file=$(find . -name "*.c")
i=0
for x in $file; do
    echo "$i) " " $x"
    i=$(( $i + 1 ))
done
num=-1
read num
if [ "$num" = "" ]
then
    x=$(<temp_for_ci.txt)
    gcc -std=c99 -Wall -Werror -Wpedantic -Wextra -Wfloat-equal -Wfloat-conversion -o go.exe $x -lm
    if [ $? -eq 0 ]
    then
        ./go.exe
        rm go.exe
    fi
    exit 0
fi
i=0
for x in $file; do
    if [ $i -eq $num ]
    then
        gcc -std=c99 -Wall -Werror -Wpedantic -Wextra -Wfloat-equal -Wfloat-conversion -o go.exe $x -lm
        echo "$x" > temp_for_ci.txt
    fi
    i=$(( $i + 1 ))
done
if [ $? -eq 0 ]
then
    ./go.exe
    rm go.exe
fi
