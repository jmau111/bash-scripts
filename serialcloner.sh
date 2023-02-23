#!/usr/bin/env bash
# Credit : Julien maury

trap 'echo -e "\033[31mScript failed with an unexpected error!\033[0m" >&2; exit 1' ERR

if ! [ -x "$(command -v git)" ]; then
    echo -e "\e[1;31mI need Git. Please install it on your system. For example 'sudo apt install -y git' on Debian\033[0m" >&2
    exit 1
fi

if [ $# -eq 0 ]; then
    >&2 echo -e "\e[1;31mNo username/org provided!\033[0m"
    exit 1
fi

target=$1
mkdir -p "$target" && cd "$target"

req="https://api.github.com/users/$target/repos?per_page=200"
while IFS= read -r line; do
  repo=$(echo "$line" | grep -oP '"ssh_url":\s"[^"]+' | awk -F '"' '{print $4}')
  [ -z "$repo" ] || git clone "$repo"
done < <(curl -s "$req")

ls
