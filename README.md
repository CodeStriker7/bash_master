# bash_master
bash scripts learn  with AI

Learn cheatsheet

1.Shebang (#!) — "Who am I ?"

>>> #!/bin/bash

2.O'zgaruvchilar (Variables)

E'lon qilish: NAME="FREE" (Diqqat: = atrofida bo'sh joy bo'lmasligi shart!)
Ishlatish: $NAME (Oldiga $ belgisi qo'yilsa, uning ichidagi ma'lumotni olinadi)
Buyruq natijasini saqlash: IP=$(dig +short google.com). Bu yerda $(...) qavs ichidagi 
buyruqni bajaradi va natijasini o'zgaruvchiga yuklaydi.

3.Tsikllar (Loops) — "Takrorlash"

while read: Faylni qatorma-qator o'qish uchun eng yaxshi usul.
for: Ma'lum bir ro'yxat (masalan, portlar: 80, 443, 22) bo'yicha aylanib chiqish uchun qulay.

4.Shartli operatorlar (If/Else) — "Qaror qabul qilish"

# bash
if [ "$status" == "200" ]; then
    echo "Hammasi zo'r"
else
    echo "Xato bor"
fi

[ va ]: Bu aslida test buyrug'i. Ularning ichidagi bo'sh joylar juda muhim!

$?: Bu Linux-ning "siri". Oxirgi bajarilgan buyruq muvaffaqiyatli bo'lsa 0, xato bo'lsa boshqa son qaytaradi. Biz portlarni tekshirishda shundan foydalandik.

5.Quvurlar va Yo'naltirish (Pipes & Redirection)
Bash-ning eng kuchli tomoni — bir buyruq natijasini ikkinchisiga berish:

    | (Pipe): Ma'lumotni zanjirdek uzatadi. curl ... | grep "server" (Curl natijasini olib, ichidan server degan so'zni qidir).

    >>: Natijani faylning oxiriga qo'shib qo'yadi.

Mini shablon 

#!/bin/bash

# 1. O'zgaruvchilar
SITE="google.com"
LOG="my_log.txt"

# 2. Asosiy ish
echo "Tekshirilmoqda: $SITE"

# 3. Mantiqiy tekshiruv
if ping -c 1 $SITE > /dev/null; then
    echo "$(date): $SITE ishlayapti" >> $LOG
else
    echo "$(date): $SITE o'chgan!" >> $LOG
fi
