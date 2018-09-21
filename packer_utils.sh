#!/bin/bash
#
# Converts uname strings to string found in gox to download hashi corp tools.

set -e

# could use an associative array, but this more compatible. bash 3 still a thing?
# fallthrough case syntax is also bash 4+
golang_arch_string() {
    local arch="$1"
    case "${arch}" in
      i386   ) echo "386";;
      i686   ) echo "386";;
      x86_64 ) echo "amd64";;
      aarch64) echo "arm64";;
      *      ) local not_found=1;;
    esac

    if [ -n "${not_found}" ]; then 
        echo "Don't know how to translate '${arch}'."
        return 1
    fi
    return 0
}

readonly operating_system=$(uname -s | awk '{ print tolower($0)}')
readonly arch=$(golang_arch_string "$(uname -m)")

echo "${operating_system}-${arch}"
