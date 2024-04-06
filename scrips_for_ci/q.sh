#!/bin/bash
if [ "$1" = "1" ]
then
    rm temp_for_ci.txt
    exit 0
fi
files=$(find . -name "main.c")

i=0
for x in $files; do
    echo "$(( $i + 1 ))) " " $x"
    i=$(( $i + 1 ))
done

num=-1
read num
if [ "$num" = "" ]
then
    dir=$(<temp_for_ci.txt)
    cd "$dir"

    files=$(find . -name "*.c")

    i=0

    files_obj=""

    for x in $files; do
        gcc -std=c99 -Wall -Werror -Wpedantic -Wextra -Wfloat-equal -Wfloat-conversion -c $x -o "ci_obj_""$(( $i + 1 ))".o -lm
        files_obj+=""ci_obj_""$(( $i + 1 ))".o "
        i=$(( $i + 1 ))
    done

    if [ $? -eq 0 ]
    then
        gcc -std=c99 -Wall -Werror -Wpedantic -Wextra -Wfloat-equal -Wfloat-conversion -o go.exe $files_obj -lm
        ./go.exe
        rm go.exe
        find . -name "*.o" -delete
    fi
        exit 0
fi

dir=0

i=0
for x in $files; do
    if [ $(( $i + 1 )) -eq $num ]
    then
        dir=$(dirname "$x")
        echo "$dir" > temp_for_ci.txt
    fi
    i=$(( $i + 1 ))
done

cd "$dir"

files=$(find . -name "*.c")

i=0

files_obj=""

for x in $files; do
    gcc -std=c99 -Wall -Werror -Wpedantic -Wextra -Wfloat-equal -Wfloat-conversion -c $x -o "ci_obj_""$(( $i + 1 ))".o -lm
   files_obj+=""ci_obj_""$(( $i + 1 ))".o "
    i=$(( $i + 1 ))
done

if [ $? -eq 0 ]
then
    gcc -std=c99 -Wall -Werror -Wpedantic -Wextra -Wfloat-equal -Wfloat-conversion -o go.exe $files_obj -lm
    ./go.exe
    rm go.exe
    find . -name "*.o" -delete
fi
