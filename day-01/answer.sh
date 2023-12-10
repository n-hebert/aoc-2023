#!/usr/bin/env cached-nix-shell
#!nix-shell -p bc gnused -i bash

# Globals {
INPUT_FILE="$(dirname "$(readlink -f "${0}")")/input"
MAX_INPUT_SIZE=$(wc -l "${INPUT_FILE}" | sed 's/ .*//')
# }

# Usage: usage
usage() {
    cat <<EOS
Usage: $(basename "$(readlink -f "${0}")") [--part 1]
  Compute part-2 by default, unless instructed to do part-1
EOS
}

# Usage: pretendToBeAComputerFromOldMovies [--part-1]
#  Like it says
pretendToBeAComputerFromOldMovies() {
    echo "UN-DOING FOOLISH ELF MISCALIBRATION." > /dev/stderr
    sleep $((${RANDOM} % 2 + 1))

    echo "COMBINING FIRST DIGIT(S) AND LAST DIGIT(S). PLEASE WAIT..." >/dev/stderr
    sleep $((${RANDOM} % 4 + 2))

    echo "WARN: SOME FIRST DIGITS *ARE* LAST DIGITS. CRUNCHING..." >/dev/stderr
    sleep $((${RANDOM} % 3 + 4))

    if [[ "${1}" != "--part-1" ]]; then
        echo "OH FOR THE LOVE OF ALL THAT IS HOLLY, ELVES, WHY ARE SOME NUMBERS WRITTEN OUT?" >/dev/stderr
        sleep $((${RANDOM} % 2 + 2))

        echo "WOW. 'TWONE'? I -- THAT'S A TWO AND A ONE? OKAY..." >/dev/stderr
        sleep $((${RANDOM} % 2 + 2))
    fi

    echo -n "CALIBRATION SUM: " >/dev/stderr
}

# Usage: processTheWholeFileWithSed --part-1
#  Much easier to just get sed to do all this
processTheWholeFileWithSed() {
    WORDS_AS_DIGITS=""
    if [[ "${1}" != "--part-1" ]]; then
        WORDS_AS_DIGITS='
        s/one/&1&/g
        s/two/&2&/g
        s/three/&3&/g
        s/four/&4&/g
        s/five/&5&/g
        s/six/&6&/g
        s/seven/&7&/g
        s/eight/&8&/g
        s/nine/&9&/g
        '
    fi
    # FIRST REGEX - DROP ALL ALPHABET CHARACTERS
    #  We don't need them

    # SECOND REGEX - HAS ONLY ONE DIGIT ON THE LINE
    # Double it

    # THIRD REGEX - HAS AT LEAST TWO DIGITS ON THE LINE
    #   From the BOL ^, take the first [[:digit:]] and \(save\) it.  We can
    #   then accept any input, [[:digit:]]*, then a [[:digit:]] we'll save,
    #   then EOL, $, should be seen
    sed \
        "${WORDS_AS_DIGITS}"'
            s/[[:alpha:]]*//g
            s/^[[:digit:]]$/&&/
            s/^\([[:digit:]]\)[[:digit:]]*\([[:digit:]]\)$/\1\2/
            ' "${INPUT_FILE}"

}

# Usage: main "${@}"
#  Does the computation
main(){
    if [[ "${1}" == "--help" || "${1}" == "-h" ]]; then
        usage
        exit 0
    fi

    # Unless someone says to stop, ham it up really badly
    [[ -z "${PLZ_STOP}" ]] && pretendToBeAComputerFromOldMovies "${@}"
    # Here's the actual code
    parsedContent="$(processTheWholeFileWithSed "${@}")"

    # Ensure nothing failed before passing it into the calculator
    if [[ ${?} -eq 0 ]]; then
        # Echo it, split it to a file for debugging, swap all new-lines for
        # pluses, but remove any trailing plus
        echo "${parsedContent}" | tee ${INPUT_FILE/input/output} | tr '\n' '+' | sed 's/+[[:space:]]*$/\n/' | bc -l
    else
        echo "ERR: Failed to parse" >/dev/stderr
    fi
}

main "${@}"
