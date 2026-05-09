#!/bin/bash

# Ranglar
SUCCESS='\033[0;32m'
ERROR='\033[0;31m'
INFO='\033[0;34m'
NC='\033[0m'

INPUT_FILE="sites.txt"
LOG_FILE="log_history.txt"

clear
echo -e "${INFO}--- Site Sentinel v2.0 (Mass Scan Edition) ---${NC}"

if [ ! -f "$INPUT_FILE" ]; then
    echo -e "${ERROR}Xato: $INPUT_FILE topilmadi!${NC}"
    echo -e "${INFO}Maslahat: Skanerlash uchun saytlarni $INPUT_FILE fayliga yozing.${NC}"
    exit 1
fi

echo -e "${INFO}Ro'yxat o'qilmoqda: $INPUT_FILE${NC}\n"

while read -r URL || [ -n "$URL" ]; do
    # Bo'sh qatorlarni va izohlarni tashlab o'tish
    [[ -z "$URL" || "$URL" =~ ^# ]] && continue

    echo -e "${INFO}🔍 $URL tekshirilmoqda...${NC}"

    # 1. HTTP Status kodi
    status_code=$(curl -IsL "$URL" --max-time 5 -o /dev/null -w "%{http_code}")

    # 2. Server turi
    server_type=$(curl -IsL "$URL" --max-time 5 | grep -i "^server:" | head -n 1 | cut -d' ' -f2- | tr -d '\r')

    # 3. IP Manzil
    ip_address=$(dig +short "$URL" | head -n 1)

    # print natijalar
    echo "------------------Result--------------------"
    if [ "$status_code" == "200" ]; then
        echo -e "${SUCCESS} Holati: OK (Status: $status_code)${NC}"
    elif [ "$status_code" == "000" ]; then
        echo -e "${ERROR} Holati: Ulanib bo'lmadi (Timeout)${NC}"
    else
        echo -e "${ERROR} Holati: Muammo bor (Status: $status_code)${NC}"
    fi

    echo -e "${INFO}🖥️  Server: ${server_type:-Nomalum}${NC}"
    echo -e "${INFO}🌐 IP: ${ip_address:-Topilmadi}${NC}"

    # 4. Portlarni tekshirish (Ichki tsikl)
    echo -e "${INFO} Portlarni tekshirish:${NC}"
    for port in 80 443 22 21; do
        (timeout 1 bash -c "cat < /dev/null > /dev/tcp/$URL/$port") 2>/dev/null
        if [ $? -eq 0 ]; then
            echo -e "${SUCCESS}  [+] Port $port: OCHIQ${NC}"
        else
            echo -e "${ERROR}  [-] Port $port: YOPIQ${NC}"
        fi
    done

    current_time=$(date "+%Y-%m-%d %H:%M:%S")
    log_entry="{ 'sana': '$current_time', 'url': '$URL', 'ip': '${ip_address:-N/A}', 'status': '$status_code', 'server': '${server_type:-N/A}' }"
    echo "$log_entry" >> "$LOG_FILE"

    echo -e "-----------------finish---------------------\n"

done < "$INPUT_FILE"

echo -e "${SUCCESS}Barcha saytlar tekshirildi! Loglar $LOG_FILE faylida.${NC}"
exit 0