#!/usr/bin/env bash

trap 'echo -e "\033[31mScript failed with an unexpected error!\033[0m" >&2; exit 1' ERR

if [ $# -eq 0 ]; then
  echo "Usage: $0 [ /path/to/dir/ ]"
  exit 1
fi

target=$1

if [[ ! -d "$target" ]]; then
  echo -e "\e[1;31mthis directory does not seem to exist on your system\033[0m"
  exit 1
fi

function sanitize {
  local file="$1"
  local d="$(dirname "$file")"
  local base="$(basename "$file")"
  local ext="${base##*.}"
  local new_base="$(echo "${base%.*}" | iconv -f utf8 -t ascii//TRANSLIT | tr -s ' ' '_')"
  local new_file="$d/$new_base.$ext"
  echo "$new_file"
}

export -f sanitize

# look for files with an extension
files=$(find "$target" -type f -name "*.*" -print)

if [ -z "$files" ]; then
  echo "No files to rename."
  exit 0
fi

count=0
while IFS= read -r file; do  
  new_file=$(sanitize "$file")
  if [ "$file" != "$new_file" ]; then
    mv -- "$file" "$new_file"
    count=$((count + 1))
  fi
done <<< "$files"

if [ $count -eq 0 ]; then
  echo "No files to rename."
  exit 0
fi

echo "Renamed $count file$([ $count -eq 1 ] || echo s)"
