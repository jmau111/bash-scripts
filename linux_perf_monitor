#!/bin/bash

trap 'echo -e "\033[31mScript failed with an unexpected error!\033[0m" >&2; exit 1' ERR

# SETTINGS
MIN=29
AVR=49
MAX=79

# COLORS
END="\033[0m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
YELLOW="\033[3;33m"
PURPLE="\033[0;35m"
RED="\033[0;31m"

# UTILS
function printcritical() {
	echo -e "$RED$1$END"
}

function printalert() {
	echo -e "$PURPLE$1$END"
}

function printwarning() {
	echo -e "$YELLOW$1$END"
}

function printnormal() {
	echo -e "$GREEN$1$END"
}

function printinfo() {
	echo "$1: $2$3"
}

function checkstatus() {
	if [[ "$(echo " $2 < $MIN " | bc -l)" == 1 ]]; then
		printnormal "$1 looks normal"
	elif [[ "$(echo " $2 > $MIN " | bc -l)" == 1 && "$(echo " $2 < $AVR" | bc -l)" == 1 ]]; then
		printwarning "$1 seems a bit high"
	elif [[ "$(echo " $2 > $AVR" | bc -l)" == 1 && "$(echo " $2 < $MAX" | bc -l)" == 1 ]]; then
		printalert "$1 is high!"
	elif [[ "$(echo " $2 > $MAX " | bc -l)" == 1 ]]; then
		printcritical "$1 is critical!"
	fi
}

# GET AND FORMAT DATA
cpu_usage=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}' | tr % ' ')
memory_total=$(free -m | awk '$1 == "Mem:" {print $2}')
memory_used=$(free -m | awk '$1 == "Mem:" {print $3}')
memory_percent=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')

printinfo "processor" $(grep "^processor" /proc/cpuinfo | wc -l) " cores"
printinfo "CPU usage" $cpu_usage "%"
printinfo "memory usage" "$memory_used/$memory_total" " ($memory_percent%)"

# STATUS
checkstatus "CPU usage" $cpu_usage
checkstatus "Memory usage" $memory_percent
