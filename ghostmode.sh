#!/bin/bash

# Renk tanımlamaları
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner
echo -e "${CYAN}"
echo "   ____  __  ______  __________  __  ______  ____  ______"
echo "  / __ \/ / / / __ \/ ___/_  __//  |/  / __ \/ __ \/ ____/"
echo " / /_/ / /_/ / / / /\__ \ / /  / /|_/ / / / / / / / __/   "
echo "/ _, _/ __  / /_/ /___/ // /  / /  / / /_/ / /_/ / /___   "
echo "/_/ |_/_/ /_/\____//____//_/  /_/  /_/\____/_____/_____/   "
echo -e "${NC}"
echo -e "${YELLOW}[OpSec] Linux Trace Cleaner & Anti-Forensics Tool${NC}"
echo "---------------------------------------------------------"

# Root kontrolü (Bazı logları temizlemek için root gerekir)
if [ "$EUID" -ne 0 ]; then 
  echo -e "${RED}[!] Lütfen bu scripti root yetkileriyle çalıştırın (sudo ./ghostmode.sh)${NC}"
  exit
fi

# Onay isteği
echo -e "${RED}UYARI: Bu işlem sistem loglarını, geçmişi ve önbelleği geri döndürülemez şekilde silecektir.${NC}"
read -p "Devam etmek istiyor musunuz? (E/H): " choice
if [[ ! $choice =~ ^[Ee]$ ]]; then
    echo "İşlem iptal edildi."
    exit 1
fi

echo ""

# 1. Bash Geçmişini Temizle (Secure Wipe)
echo -e "${CYAN}[*] Bash geçmişi temizleniyor (Shredding)...${NC}"
if [ -f ~/.bash_history ]; then
    shred -u -z -n 3 ~/.bash_history
    echo -e "${GREEN}[+] .bash_history güvenli şekilde silindi.${NC}"
else
    echo -e "${YELLOW}[-] .bash_history bulunamadı.${NC}"
fi
history -c

# 2. Thumbnail (Küçük Resim) Önbelleğini Temizle
# Linux'ta açtığınız resimlerin küçük kopyaları burada saklanır.
echo -e "${CYAN}[*] Resim önbellekleri temizleniyor...${NC}"
rm -rf /home/*/.cache/thumbnails/*
rm -rf /root/.cache/thumbnails/*
echo -e "${GREEN}[+] Thumbnails önbelleği temizlendi.${NC}"

# 3. Paket Yöneticisi (DNF/APT) Önbelleğini Temizle
echo -e "${CYAN}[*] Paket yöneticisi önbelleği temizleniyor...${NC}"
if command -v dnf &> /dev/null; then
    dnf clean all &> /dev/null
    echo -e "${GREEN}[+] Fedora (DNF) önbelleği temizlendi.${NC}"
elif command -v apt-get &> /dev/null; then
    apt-get clean &> /dev/null
    echo -e "${GREEN}[+] Debian/Ubuntu (APT) önbelleği temizlendi.${NC}"
fi

# 4. Sistem Loglarını Temizle (Sadece içeriklerini boşalt, dosyayı silme)
echo -e "${CYAN}[*] Sistem logları boşaltılıyor...${NC}"
# /var/log altındaki .log dosyalarının içini boşalt
find /var/log -type f -name "*.log" -exec truncate -s 0 {} \;
echo -e "${GREEN}[+] /var/log altındaki log dosyaları sıfırlandı.${NC}"

# 5. Geçici Dosyaları (/tmp) Temizle
echo -e "${CYAN}[*] Geçici dosyalar (/tmp) temizleniyor...${NC}"
rm -rf /tmp/*
echo -e "${GREEN}[+] /tmp klasörü temizlendi.${NC}"

echo ""
echo -e "${GREEN}✔ GhostMode Tamamlandı. İzler silindi.${NC}"
echo -e "${YELLOW}Not: Unutma, %100 gizlilik diye bir şey yoktur. Sadece işleri zorlaştırdık.${NC}"
