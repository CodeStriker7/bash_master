#!/bin/bash

# Fayllar
LOG_FILE="network_monitor.log"
REPORT_FILE="network_report.txt"

echo "================================" | tee -a $LOG_FILE
echo "Sana: $(date)" | tee -a $LOG_FILE
echo "================================" | tee -a $LOG_FILE

# Interfeyslar
echo -e "\n--- Tarmoq Interfeyslar ---" | tee -a $LOG_FILE
nmcli device status | tee -a $LOG_FILE

# Ulanish holati
echo -e "\n--- Hozirgi Ulanish ---" | tee -a $LOG_FILE
nmcli connection show --active | tee -a $LOG_FILE

# Wi-Fi signal darajasi
echo -e "\n--- Wi-Fi Tarmoqlar ---" | tee -a $LOG_FILE
nmcli -f SSID,SIGNAL,SECURITY device wifi list | tee -a $LOG_FILE

echo -e "\nLog saqlandi: $LOG_FILE"
#!/bin/bash
echo "=== IP Manzil ==="
hostname -I

echo "=== Router ==="
ip route | grep default

echo "=== Internet tezligi (ping) ==="
ping -c 3 8.8.8.8 | tail -1

echo "=== Faol ulanishlar ==="
ss -tuln | grep LISTEN
