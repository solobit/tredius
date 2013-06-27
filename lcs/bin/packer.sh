#!/usr/bin/env bash

[[ -z "${1}" ]] && { echo "You must provide a file name"; exit 1; }
[[ -f "${1}" ]] || { echo "File '$1' doesn't exist."; exit 1; }

input="${1}"
output="${input%.*}.json"

bname=`basename $input .litcoffee`
[[ "${input#*.}" = "litcoffee" ]] || {
    echo "File '$1' is not a literate coffeescript file.";
    exit 1;
  } && {
  # Temp solution, to remove the 'compiled by' text and remove first/last );
    coffee -p -b $input | sed 's/^[ \t \(]*//;s/[ \t \);]*$//' > $output

}




exit $?
