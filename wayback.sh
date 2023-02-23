#!/usr/bin/env bash

trap 'echo -e "\033[31mScript failed with an unexpected error!\033[0m" >&2; exit 1' ERR

if ! [ -x "$(command -v curl)" ]; then
  echo -e "\033[31mI need curl. Please install it on your system. For example 'sudo apt install -y curl' on Debian\033[0m"
  exit 1
fi

url=$1

if [ -z "$url" ]; then
  echo -e "\033[31mError: No URL was specified.\033[0m"
  echo "Usage: $0 [ URL ]"
  exit 1
fi

response=$(curl -L -s -w "%{http_code}" -o /dev/null "$url")

if [ "$response" != "200" ]; then
  echo -e "\033[31mError: URL is not responding. Response code: $response\033[0m"
  exit 1
fi

response=$(curl -L -s -w "%{http_code}" -o /dev/null "https://web.archive.org/save/$url")

if [ "$response" != "200" ]; then
  echo -e "\033[31mError: Could not archive URL. Response code: $response\033[0m"
  exit 1
fi

echo -e "\033[32mTimemap: https://web.archive.org/web/timemap/link/$url\033[0m"
echo -e "\033[32mArchive: https://web.archive.org/web/$url\033[0m"
