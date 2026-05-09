#!/bin/bash

# Ranglar
GREEN='\033[0;32m'
BRIGHT_GREEN='\033[1;32m'
NC='\033[0m'

# Terminal o'lchamlarini olish (xatolikka chidamli usul)
COLUMNS=$(tput cols)
LINES=$(tput lines)

# Agar tput o'qiy olmasa, standart qiymatlar
COLUMNS=${COLUMNS:-80}
LINES=${LINES:-24}

# Ustunlar pozitsiyasini saqlash uchun massiv
declare -a rain_pos

# Pozitsiyalarni tasodifiy boshlash
for ((i=0; i<COLUMNS; i++)); do
    rain_pos[$i]=$((RANDOM % LINES))
done

# Kursorni yashirish va ekranni tozalash
tput civis
clear

# To'xtatilganda (Ctrl+C) kursorni qaytarish
trap "tput cnorm; clear; exit" SIGINT SIGTERM

while true; do
    for ((i=0; i<COLUMNS; i++)); do
        # Tasodifiylik: har doim ham pastga tushavermaydi (oqim effekti uchun)
        if [ $((RANDOM % 10)) -gt 1 ]; then
            
            # Joriy pozitsiyaga borish
            tput cup ${rain_pos[$i]} $i
            
            # Tasodifiy belgi (ASCII 33-126 oraliqda)
            # printf dagi xatolikni oldini olish uchun sodda usul:
            char_code=$((RANDOM % 94 + 33))
            char=$(printf "\\x$(printf '%x' $char_code)")
            
            # "Bosh" qismi och yashil, qolgan qismi to'q yashil
            if [ $((RANDOM % 5)) -eq 0 ]; then
                echo -ne "${BRIGHT_GREEN}${char}${NC}"
            else
                echo -ne "${GREEN}${char}${NC}"
            fi
            
            # Pozitsiyani yangilash
            rain_pos[$i]=$(( (rain_pos[$i] + 1) % LINES ))
            
            # Orqasidan "tozalab" ketish (fading effekti uchun bo'sh joy tashlash)
            # 15 qatordan keyingi belgini o'chiradi
            blank_pos=$(( (rain_pos[$i] - 15 + LINES) % LINES ))
            tput cup $blank_pos $i
            echo -ne " "
        fi
    done
    sleep 0.05
done