#!/usr/bin/env bash

## Simple script to chech server stats

# Colour variables for easier use
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
B='\033[0;34m'
MA='\033[0;35m'
CY='\033[0;36m'
W='\033[0;37m'
BO='\033[1m'
UN='\033[4m'
REV='\033[7m'
NC='\033[0m' # No Color (reset)

echo -e "${R}==================== Server Performance Stats ====================${NC}"

CPU_USAGE=$(mpstat|tail -n 1|awk '{print 100 - $NF"%"}')
echo -e "${B}TOTAL CPU usage${NC}: ${CPU_USAGE}"
echo ""
Total_mem=$(free -m | awk 'NR==2{printf"Used:%sMB (%.2f%%)\n Free:%sMB (%.2f%%) \n", $3/1024, $3*100/$2, $4, $4*100/$2}' )
echo -e "${B}MEMORY USAGE:${NC}\n ${Total_mem}"
echo ""
Dsk_Usage=$(df -BM | awk '$NF=="/"{printf"Used:%s (%.2f%%)\n Free:%s (%.2f%%)",$3, $3*100/$2,$4,$4*100/$2 }')
echo -e "${B}DISK USAGE:${NC}\n ${Dsk_Usage}"
echo ""
Procs_cpu=$(ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6)
echo -e "${G}TOP FIVE PROCESS BY CPU:${NC}\n ${Procs_cpu}"
echo ""
Procs_mem=$(ps -eo pid,comm,%mem --sort=-%mem | head -n 6)
echo -e "${G}TOP FIVE PROCESS BY MEM:${NC}\n ${Procs_mem}"
echo ""
OS_Name=$(hostnamectl | grep -i operating | awk -F ':' '{print $NF}')
echo -e "${Y}OS VERSION:${NC}${OS_Name}"
echo ""
UPTIME=$(uptime -p)
echo -e "${Y}UPTIME:${NC} $UPTIME"
echo ""
LOAD_AVERAGE=$(uptime | awk -F 'load average:' '{ print $2 }')
echo -e "${Y}Load Average:${NC} $LOAD_AVERAGE"
echo ""
echo "Logged in users: $(who | awk '{print $1}'| sort | uniq | tr '\n' ' ')"
echo -e "${R}==================== Server Performance Stats ====================${NC}"
