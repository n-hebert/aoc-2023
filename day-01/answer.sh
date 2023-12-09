#!/usr/bin/env bash

# Globals {
INPUT_FILE="$(dirname "$(readlink -f ${0})")/input"
MAX_INPUT_SIZE=$(wc -l "${INPUT_FILE}" | sed 's/ .*//')
# }

# Usage: pretendToBeAComputerFromOldMovies
#  Like it says
pretendToBeAComputerFromOldMovies() {
    echo "UN-DOING ELFIES MISCALIBRATION... PLEASE WAIT"

    echo "COMBINING FIRST DIGIT AND LAST DIGIT"
}

# Usage: sanityCheck COUNT MAX
#  Makes sure I didn't loop myself into oblivion
sanityCheck() {
    count="${1}"
    max=$"${2}"
    if [[ ${count} == ${max} ]]; then
        echo "You goofed, Nick." > /dev/stderr
        exit 1
    fi
}

# Usage: actuallyDoWork
#  The answer itself
actuallyDoWork() {
    count=1
    while read line; do
        # track loop
        sanityCheck "${count}" $((${MAX_INPUT_SIZE} + 1))
        count=$((count + 1))

        # compute the answer
        echo "${line}"
    done < "${INPUT_FILE}"
}

# Usage: main
#  Does the computation
main(){
    pretendToBeAComputerFromOldMovies
    actuallyDoWork
}

main
