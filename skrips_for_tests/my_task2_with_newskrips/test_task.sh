#!/bin/bash

status="0"

passed="\033[1;32m(PASSED)\033[0m"
failed="\033[1;31m(FAILED)\033[0m"
info="\033[1;34m(INFO):\033[0m"

one_level_tab="    "

./clean.sh

# Check options
tabs=""
verbose_opt=""

if [ $status == "0" ]; then
	# Run sc
	prefix="SHELLCHECK"
	if t_output=$(./check_scripts.sh "$tabs""$one_level_tab" "$verbose_opt" 2>&1); then
		echo -e "$tabs""$prefix" "$passed"
	else
		echo -e "$tabs""$prefix" "$failed"
	fi
	echo "$t_output"
fi

echo
echo
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
echo
echo

if [ -f "CodeChecker.exe" ]; then
    # Run codestyle check
    prefix="CODESTYLE"
    for file in *.c; do
        if t_output=$(./CodeChecker.exe "$file" 2>&1); then
            echo -e "$tabs""$prefix" "$passed"
        else
            echo -e "$tabs""$prefix" "$failed"
        fi
        if [ -n "$t_output" ]; then
            echo -e $info
            while IFS= read -r line; do
                echo "$tabs""$one_level_tab""$line"
            done <<< "$t_output"
            echo
        fi
    done
fi



# If scripted
if [ $status == "0" ]; then
	# Check builds
	prefix="BUILD"
	if t_output=$(./check_builds.sh "$tabs""$one_level_tab" 2>&1); then
		echo -e "$tabs""$prefix" "$passed"
	else
		status="1"
		echo -e "$tabs""$prefix" "$failed"
	fi
	echo "$t_output"
fi

# If buildable
if [ $status == "0" ]; then
	# Run func_tests on all builds
	prefix="USER FUNC TEST"
	if t_output=$(./check_functional_tests.sh "$tabs""$one_level_tab" "$verbose_opt" 2>&1); then
		echo -e "$tabs""$prefix" "$passed"
	else
		status="1"
		echo -e "$tabs""$prefix" "$failed"
	fi
	echo "$t_output"
fi

# If testable
if [ $status == "0" ]; then
	# Collect coverage
	prefix="COVERAGE"
	if t_output=$(./collect_coverage.sh "$tabs""$one_level_tab" 2>&1); then
		echo -e "$tabs""$prefix" "$passed"
	else
		status="1"
		echo -e "$tabs""$prefix" "$failed"
	fi
	echo "$t_output"
fi

rm -f ./*.o

exit $status