#!/bin/bash

# The script takes two arguments.
#   1 = the filename of the drawio to process
#   2 = the output directory for any generated svg

INPUT_FILENAME=${1}
OUTPUT_DIRECTORY=${2}

function help() {
    echo "Usage $0 <input filename> <output directory>" 1>&2
    exit -1
}

if [[ "$INPUT_FILENAME" == "" ]] || [[ "$OUTPUT_DIRECTORY" == "" ]];
then
    help
fi

if [[ `uname -s` == 'Darwin' ]]; then
    # Mac OS X
    DRAWIO="/Applications/draw.io.app/Contents/MacOS/draw.io"
else
    # Linux
    DRAWIO="drawio"
fi

TABS=`xmllint --xpath '//diagram/@name' "${INPUT_FILENAME}" | cut -d'"' -f2`
NTABS=`echo "${TABS}" | wc -w`

if [[ ${NTABS} -eq 0 ]]; then
    echo "No tabs found in ${1}"
    exit 1
elif [[ ${NTABS} -eq 1 ]]; then
    OUT="${OUTPUT_DIRECTORY}/$(echo $INPUT_FILENAME | sed 's|.*[/\]\([^/\]*\)$|\1|g').svg"
    $DRAWIO -x -f svg -o "${OUT}" "${1}"
else
    TAB=0
    echo "$TABS" | while read TABNAME; do
        OUT="${OUTPUT_DIRECTORY}/$(echo $INPUT_FILENAME | sed 's|.*[/\]\([^/\]*\)$|\1|g').${TABNAME}.svg"
        $DRAWIO -x -f svg -o "${OUT}" -p "${TAB}" "${1}"
        ((TAB++))
    done
fi
