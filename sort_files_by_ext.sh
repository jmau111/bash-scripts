#!/usr/bin/env bash

trap 'echo -e "\033[31mScript failed with an unexpected error!\033[0m" >&2; exit 1' ERR

d="${1:-$PWD}"

if [ ! -d "$d" ]; then
  echo -e "\033[31mError: The targeted directory does not exist\033[0m"
  exit 1
fi

# Edge case when the targeted dir is outside user home dir
if [[ ! "$d" =~ "$HOME" ]]; then
  echo -e "\033[33mYou asked for $d, but it is not in $HOME.\033[0m"
  read -p "Are you sure you want to proceed? (y/n) " answer

  [[ "$answer" == [Yy]* ]] && echo "Ok" || exit 1
fi

find "$d" -type f -printf '%f\n' | while read -r file; do

  # Don't touch the script itself in case it's executed in the same dir
  if [ "$file" == "$(basename "$0")" ]; then
    continue
  fi

  ext="${file##*.}"
  
  if [ ! -z "$ext" ]; then
    if [ ! -d "$ext" ]; then
      mkdir "$ext"
    fi
    if [ ! -f "$ext/$file" ]; then
        mv "$file" "$ext/$file"
    fi
  fi

done

echo "Done."
