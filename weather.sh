#!/bin/bash

# Simple script to show weather in terminal
# Uses wttr.in service

# Colors
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}🌍 Fetching weather information...${NC}"
echo ""

# Get weather for the current IP location
curl -s "wttr.in?m"
