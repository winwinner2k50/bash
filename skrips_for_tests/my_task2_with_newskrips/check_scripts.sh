status="0"

pass="\033[1;32mPASS\033[0m"
failed="\033[1;31mFAILED\033[0m"

# Check options
tabs=''

sc_opts=("-a" "-C" "-e" "SC2013")

prefix="script"
while IFS= read -r -d '' script
do
	if t_output=$(shellcheck "${sc_opts[@]}" "$script"); then
		echo -e "$tabs""$prefix" "$script": "$pass" "1"
	else
        echo "$t_output"
		echo -e "$tabs""$prefix" "$script": "$failed" "2"
		status="1"
	fi
done <   <(find . -name "*.sh" -print0)

exit $status