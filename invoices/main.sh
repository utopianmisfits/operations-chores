#!/usr/bin/env bash
#
# Find files in the current folder and execute them
# Unless an exclusion pattern was given

set -euo pipefail
IFS=$'\n\t'

execute_files() {
  readonly exclusion_pattern="${1}"

  if [[ -n "${exclusion_pattern}" ]]; then
    find "$(dirname "${0}")" \
      -type f \
      -iname "*.sh" \
      -not -iname "$(basename "${0}")" \
      -not -iname "*${exclusion_pattern}*" \
      -exec /bin/bash '{}' \;
  else
    find "$(dirname "${0}")" \
      -type f \
      -iname "*.sh" \
      -not -iname "$(basename "${0}")" \
      -exec /bin/bash '{}' \;
  fi
}

usage() {
  printf "Usage: %s: [-a] [-b value] args\n" "$(basename "${0}")" 1>&2
  exit 2
}

main() {
  local exclusion_pattern=

  while getopts 'e:' OPTION; do
    case "${OPTION}" in
    e) exclusion_pattern="${OPTARG}" ;;
    ?) usage ;;
    esac
  done

  execute_files "${exclusion_pattern}"
}

main "${@}"
