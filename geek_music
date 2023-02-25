#!/usr/bin/env bash

trap 'echo -e "\033[31mScript failed with an unexpected error!\033[0m" >&2; exit 1' ERR

if ! [ -x "$(command -v timidity)" ]; then
  echo -e "\e[1;31mI need the timidity package"
  echo -e "You can use 'sudo apt install -y timidity' on Debian-based systems\033[0m"
  exit 1
fi

ALLOWED_THEMES=(tetris smashbros nggyu onepiece onemoretime trtn starwars)

function usage() {
    cat 1>&2 <<EOF
The usage for $(basename $0)
(music files by bitmidi.com)
USAGE:
    ./$(basename $0) [ -t (default theme is "tetris") ]
THEMES:
    ${ALLOWED_THEMES[@]}
EOF
}

while getopts "ht:" opt; do
  case "$opt" in 
    t) 
      theme=${OPTARG}
      ;;
    h) 
      usage;
      exit 0
      ;;
  esac
done

shift $((OPTIND-1)) # clear options

_theme=${theme-tetris}

if [[ ! " ${ALLOWED_THEMES[@]} " =~ " $_theme " ]]; then
  echo -e "\e[1;31mThe theme $_theme is not available!\033[0m"
  exit 1
fi

mid_file="$PWD/themes/$_theme.mid"

if [[ ! -f "$mid_file" ]]; then
  echo -e "\e[1;31mI cannot find the .mid file for the theme $_theme\033[0m"
  exit 1
fi

timidity -B2,8 -EFreverb=0 -EFresamp=0 -EFWaveOut $mid_file
