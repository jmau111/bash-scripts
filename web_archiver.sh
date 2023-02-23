#!/usr/bin/env bash

trap 'echo -e "\033[31mScript failed with an unexpected error!\033[0m" >&2; exit 1' ERR

if ! [ -x "$(command -v wget)" ]; then
  echo -e "\033[31mI need wget. Please install it on your system. For example 'sudo apt install -y wget' on Debian\033[0m"
  exit 1
fi

url=$1

if [ -z "$url" ]; then
  echo -e "\033[31mMissing URL\033[0m"
  echo "Usage: $0 [ URL ]"
  exit 1
fi

wget -r --no-parent $url

if [ $? -ne 0 ]; then
  echo -e "\033[31mThere was an error during scrapping...\033[0m"
fi
