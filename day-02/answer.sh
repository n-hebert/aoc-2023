#!/usr/bin/env cached-nix-shell
#!nix-shell -p bash bc gnused -i bash

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

# Usage: main "${@}"
#  As self-described, the main function and entrypoint
main(){
    if [[ "${1}" == "--help" || "${1}" == "-h" ]]; then
        usage
        exit 0
    fi
}

main "${@}"
