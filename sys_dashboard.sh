#!/bin/bash

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color
BOLD='\033[1m'

clear

echo -e "${BLUE}${BOLD}=========================================="
echo -e "       💻 SYSTEM MONITOR DASHBOARD"
echo -e "==========================================${NC}"

# Date and Time
echo -e "${GREEN}📅 Date:${NC} $(date '+%Y-%m-%d %H:%M:%S')"
echo -e "${GREEN}🕒 Uptime:${NC} $(uptime -p)"

echo -e "\n${BLUE}${BOLD}--- CPU & Load ---${NC}"
cpu_load=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo -e "${GREEN}⚙️ CPU Usage:${NC} ${cpu_load}%"
echo -e "${GREEN}📊 Load Avg:${NC} $(cat /proc/loadavg | awk '{print $1, $2, $3}')"

echo -e "\n${BLUE}${BOLD}--- Memory Usage ---${NC}"
# Get RAM info in a nice format
free -h | awk 'NR==2{printf "🧠 RAM: %s / %s (%.2f%%)\n", $3, $2, $3*100/$2 }'

echo -e "\n${BLUE}${BOLD}--- Disk Usage ---${NC}"
df -h | grep '^/dev/' | awk '{ printf "💽 %-15s %s / %s (%s)\n", $1, $3, $2, $5 }'

echo -e "\n${BLUE}${BOLD}--- Network Status ---${NC}"
ip_addr=$(hostname -I | awk '{print $1}')
echo -e "${GREEN}🌐 Local IP:${NC} ${ip_addr}"

echo -e "${BLUE}${BOLD}==========================================${NC}"
