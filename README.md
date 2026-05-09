# 🖥️ Bash Master

> Bash skriptlarni AI yordamida o'rganish uchun interaktiv cheatsheet va amaliy qo'llanma.

---

## 📋 Mundarija

- [Shebang](#1-shebang)
- [O'zgaruvchilar](#2-ozgaruvchilar)
- [Tsikllar](#3-tsikllar)
- [Shartli operatorlar](#4-shartli-operatorlar)
- [Quvurlar va Yo'naltirish](#5-quvurlar-va-yonaltirish)
- [Mini shablon](#-mini-shablon)

---

## 1. Shebang

**«Men kim?»** — skript qaysi interpreter orqali ishlashini belgilaydi.

```bash
#!/bin/bash
```

> 💡 Har doim birinchi qatorda bo'lishi shart. Bu bo'lmasа, skript noto'g'ri interpreter bilan ishga tushishi mumkin.

---

## 2. O'zgaruvchilar

### E'lon qilish

```bash
NAME="FREE"    # to'g'ri ✅
NAME = "FREE"  # xato ❌ — = atrofida bo'sh joy bo'lmasin!
```

### Ishlatish

```bash
echo "Salom, $NAME"
echo "Salom, ${NAME}!"   # to'g'riroq usul
```

### Buyruq natijasini saqlash

```bash
IP=$(dig +short google.com)
echo "IP manzil: $IP"

DATE=$(date +%Y-%m-%d)
echo "Bugun: $DATE"
```

> 💡 `$(...)` — qavs ichidagi buyruqni bajarib, natijasini o'zgaruvchiga yuklaydi.

---

## 3. Tsikllar

### `while read` — faylni qatorma-qator o'qish

```bash
while read line; do
    echo "$line"
done < fayl.txt
```

### `for` — ro'yxat bo'yicha aylanish

```bash
# Portlar ro'yxati bo'yicha
for port in 80 443 22; do
    echo "Tekshirilmoqda: $port"
done

# Raqam oralig'i bo'yicha
for i in {1..5}; do
    echo "Qadam: $i"
done

# Fayllar bo'yicha
for file in *.txt; do
    echo "Fayl: $file"
done
```

---

## 4. Shartli operatorlar

### Asosiy `if/else`

```bash
if [ "$status" == "200" ]; then
    echo "Hammasi zo'r"
else
    echo "Xato bor"
fi
```

### Muhim belgilar

| Operator | Ma'nosi |
|----------|---------|
| `==` | teng |
| `!=` | teng emas |
| `-eq` | raqamlar teng |
| `-gt` | kattaroq (`>`) |
| `-lt` | kichikroq (`<`) |
| `-f` | fayl mavjud |
| `-d` | papka mavjud |
| `-z` | satr bo'sh |

```bash
# Fayl mavjudligini tekshirish
if [ -f "config.txt" ]; then
    echo "Fayl mavjud"
fi

# Raqamlarni solishtirish
if [ "$count" -gt 10 ]; then
    echo "10 dan ko'p"
fi
```

### `$?` — oxirgi buyruq natijasi

```bash
ping -c 1 google.com > /dev/null
if [ $? -eq 0 ]; then
    echo "Ulanish muvaffaqiyatli"
else
    echo "Ulanmadi"
fi
```

> 💡 `$?` — Linux-ning «siri». Muvaffaqiyat = `0`, xato = boshqa son.

---

## 5. Quvurlar va Yo'naltirish

Bash-ning eng kuchli tomoni — bir buyruq natijasini ikkinchisiga berish.

```bash
# | (pipe) — ma'lumotni zanjirdek uzatadi
curl -s example.com | grep "server"
cat /etc/passwd | grep "root" | cut -d: -f1

# > — faylga yozadi (eskisini o'chiradi)
echo "yangi ma'lumot" > log.txt

# >> — faylning oxiriga qo'shib qo'yadi
echo "$(date): yangi qator" >> log.txt

# 2> — xato xabarlarini faylga yo'naltiradi
command 2> errors.txt

# /dev/null — natijani yo'q qiladi (shovqinsiz ishlash)
ping google.com > /dev/null 2>&1
```

---

## ⭐ Mini shablon

Barcha tushunchalar birlashgan amaliy misol:

```bash
#!/bin/bash

# ============================================
# Sayt monitoring skripti
# Ishlatish: ./monitor.sh
# ============================================

# 1. O'zgaruvchilar
SITE="google.com"
LOG="monitor_log.txt"
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# 2. Fayl mavjudligini tekshirish
if [ ! -f "$LOG" ]; then
    echo "Log fayl yaratilmoqda..."
    touch "$LOG"
fi

# 3. Bir nechta saytni tekshirish
SITES=("google.com" "github.com" "example.com")

for site in "${SITES[@]}"; do
    if ping -c 1 "$site" > /dev/null 2>&1; then
        echo "$DATE: ✅ $site — ishlayapti" >> "$LOG"
    else
        echo "$DATE: ❌ $site — o'chgan!" >> "$LOG"
    fi
done

# 4. Natijani ko'rsatish
echo "Tekshiruv yakunlandi. Natijalar: $LOG"
cat "$LOG" | tail -5
```

---

## 🚀 Ishlatish

```bash
# Skriptni yuklab oling
git clone https://github.com/username/bash-master.git
cd bash-master

# Bajarilish huquqini bering
chmod +x monitor.sh

# Ishga tushiring
./monitor.sh
```

---

## 📚 Qo'shimcha resurslar

- [Bash Manual (GNU)](https://www.gnu.org/software/bash/manual/)
- [ShellCheck — skriptlarni tekshirish](https://www.shellcheck.net/)
- [Bash Cheatsheet — devhints.io](https://devhints.io/bash)

---

## 🤝 Hissa qo'shish

Pull request-lar qabul qilinadi! Yangi misollar yoki tuzatishlar uchun issue oching.

---

<div align="center">
  <sub>Bash o'rganish hech qachon kech emas 🐚</sub>
</div>
