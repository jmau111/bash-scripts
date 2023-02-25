#!/usr/bin/env bash

d="${1:-$PWD}"

if [ ! -d "$d" ]; then
  echo -e "\033[31mError: The targeted directory does not exist\033[0m"
  exit 1
fi

if ! realpath --relative-to="$HOME" "$d" >/dev/null 2>&1; then
  echo -e "\033[33mYou asked for $d, but it is not in $HOME.\033[0m"
  read -p "Are you sure you want to proceed? (y/n) " answer

  [[ "$answer" == [Yy]* ]] && echo "Ok" || exit 1
fi

find "$d" -type f -not -name "$(basename "$0")" -print0 | while IFS= read -r -d '' file; do
  
  ext=$(awk -F. '{print tolower($NF)}' <<< "$file")
  _d="$d/$ext"
  if [ ! -d "$_d" ]; then
    mkdir "$_d"
  fi
  if [ ! -f "$_d/$(basename "$file")" ]; then
    mv "$file" "$_d/"
  fi
done

echo "Done."
