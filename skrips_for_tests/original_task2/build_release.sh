#!/bin/bash
gcc_compile_args=("-std=c99" "-Wall" "-Werror" "-Wpedantic" "-Wextra" "-Wfloat-equal" "-Wfloat-conversion" "-Wvla" "-fdiagnostics-color")

gcc "${gcc_compile_args[@]}" -O2 -c ./*.c

gcc -o app.exe ./*.o -lm
