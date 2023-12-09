#!/usr/bin/env cached-nix-shell
#!nix-shell -p bash bc gnused -i bash

# Globals {
INPUT_FILE="$(dirname "$(readlink -f ${0})")/input"
MAX_INPUT_SIZE=$(wc -l "${INPUT_FILE}" | sed 's/ .*//')
# }

# Usage: pretendToBeAComputerFromOldMovies
#  Like it says
pretendToBeAComputerFromOldMovies() {
    echo "UN-DOING FOOLISH ELF MISCALIBRATION." > /dev/stderr
    sleep $((${RANDOM} % 2 + 1))

    echo "COMBINING FIRST DIGIT(S) AND LAST DIGIT(S). PLEASE WAIT..." > /dev/stderr
    sleep $((${RANDOM} % 4 + 3))

    echo "WARN: SOME FIRST DIGITS *ARE* LAST DIGITS. CRUNCHING..."
    sleep $((${RANDOM} % 3 + 5))

    echo -n "CALIBRATION SUM: "
}

# Usage: processTheWholeFileWithSed
#  Much easier to just get sed to do all this
processTheWholeFileWithSed() {
    # SECOND REGEX - HAS AT LEAST TWO DIGITS ON THE LINE
    #   Before anything, we need to prune the lines we just did (/^[^+]/)
    #   From the BOL ^ we should see any amount of non-digits [^[:digit]]*.
    #   After that, we'll take any amount of [[:digit:]]\+ and \(save\) it.  We
    #   can then accept any input [[:alnum]]*, then in some [[:alpha:]], then
    #   a [[:digit:]] we'll save, then the rest of the alpha's in the line
    #   until EOL, $ can be gobbled...

    # FIRST REGEX - HAS ONLY ONE DIGIT ON THE LINE
    #   The first number can also *BE* the second number, so fine, we have
    #   not-digits [^[:digit]] as many times as we like, then a [[:digit:]]
    #   for sure, then whatever non-digits till the EOL, $.
    sed '
    s/^[^[:digit:]]*\([[:digit:]]\)[^[:digit:]]*$/\1\1 +/
    /^[^+]*/s/^[^[:digit:]]*\([[:digit:]]\)[[:alnum:]]*\([[:digit:]]\)[[:alpha:]]*$/\1\2 + /;
    ' "${INPUT_FILE}"

}

# Usage: main
#  Does the computation
main(){
    # Unless someone says to stop, ham it up really badly
    [[ -z ${PLZ_STOP} ]] && pretendToBeAComputerFromOldMovies
    # Here's the actual code
    processTheWholeFileWithSed | tee output | tr -d '\n' | sed 's/+$/\n/' | bc -l

}

main
