#!/bin/bash

if [[ `uname -s` == 'Darwin' ]]; then
    # Mac OS X
    DRAWIO="/Applications/draw.io.app/Contents/MacOS/draw.io"
else
    # Linux
    DRAWIO="drawio"
fi

TABS=`xmllint --xpath '//diagram/@name' "${1}" | cut -d'"' -f2`
NTABS=`echo "${TABS}" | wc -w`

if [[ ${NTABS} -eq 0 ]]; then
    echo "No tabs found in ${1}"
    exit 1
elif [[ ${NTABS} -eq 1 ]]; then
    OUT="${1}.svg"
    $DRAWIO -x -f svg -o "${OUT}" "${1}"
else
    TAB=0
    echo "$TABS" | while read TABNAME; do
        OUT="${1}.${TABNAME}.svg"
        $DRAWIO -x -f svg -o "${OUT}" -p "${TAB}" "${1}"
        ((TAB++))
    done
fi
