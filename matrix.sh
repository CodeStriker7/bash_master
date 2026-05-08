#!/bin/bash

# Matrix Rain Effect in Bash
# Inspired by many versions found online

# Colors and characters
GREEN='\033[0;32m'
BRIGHT_GREEN='\033[1;32m'
NC='\033[0m'

# Get terminal dimensions
COLUMNS=$(tput cols)
LINES=$(tput lines)

# Array to keep track of columns position
declare -a rain_pos

# Initialize positions
for ((i=0; i<COLUMNS; i++)); do
    rain_pos[$i]=$((RANDOM % LINES))
done

# Hide cursor
tput civis
clear

# Clean up on exit (Ctrl+C)
trap "tput cnorm; clear; exit" SIGINT SIGTERM

while true; do
    for ((i=0; i<COLUMNS; i++)); do
        # Every now and then, start a new stream or move down
        if [ $((RANDOM % 10)) -gt 1 ]; then
            # Move to current position in column
            tput cup ${rain_pos[$i]} $i
            
            # Print a random character
            char=$(printf "\\$(printf '%03o' $((RANDOM % 94 + 33)))")
            
            # Occasionally print bright green for the "head" of the stream
            if [ $((RANDOM % 5)) -eq 0 ]; then
                echo -ne "${BRIGHT_GREEN}${char}${NC}"
            else
                echo -ne "${GREEN}${char}${NC}"
            fi
            
            # Update position
            rain_pos[$i]=$(( (rain_pos[$i] + 1) % LINES ))
            
            # Leave a trail/fade effect (optional but hard in pure bash without overdrawing)
            # To keep it simple, we just move down. 
            # To clear, we can occasionally print a space behind.
            tput cup $(( (rain_pos[$i] + LINES - 15) % LINES )) $i
            echo -ne " "
        fi
    done
    sleep 0.05
done
