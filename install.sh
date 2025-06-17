#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

PANEL_PASS="hmz555"
MAX_ATTEMPTS=15
attempt=1

ENC_LINK="U2FsdGVkX1/uMHcSuo/L4qmBiJnGqiaN71BFCE1fpB/C0BBWhrIFbI0MAZ9mjRCT9etT08O3Y5vSnH7L+Orqfg=="

echo -e "${YELLOW} Checking and installing required packages... ${NC}"
if ! command -v curl &>/dev/null; then
    echo -e "${YELLOW} Installing curl... ${NC}"
    apt update -y && apt install curl -y
fi

if ! command -v openssl &>/dev/null; then
    echo -e "${YELLOW} Installing openssl... ${NC}"
    apt install openssl -y
fi

if ! command -v bash &>/dev/null; then
    echo -e "${YELLOW} Installing bash... ${NC}"
    apt install bash -y
fi

clear
echo -e "${YELLOW} Secure Access Panel${NC}"
echo -e "${YELLOW} Script is protected by password${NC}"
echo -e "${YELLOW} To get the password, contact here @a_hamza_i ${NC}" 

while [[ $attempt -le $MAX_ATTEMPTS ]]; do
    echo -n -e "${YELLOW} Enter password to access $attempt/$MAX_ATTEMPTS): ${NC}"
    read -r -s input_pass
    echo
    if [[ "$input_pass" == "$PANEL_PASS" ]]; then
        echo -e "${GREEN} Password correct. Access granted.${NC}"
        break
    else
        echo -e "${RED} Incorrect password. Try again.${NC}"
        ((attempt++))
    fi
done

if (( attempt > MAX_ATTEMPTS )); then
    echo -e "${RED} Maximum attempts reached. Exiting.${NC}"
    exit 1
fi

SCRIPT_URL=$(echo "$ENC_LINK" | openssl enc -aes-256-cbc -d -a -pbkdf2 -iter 100000 -pass pass:pass)

SCRIPT_NAME="tools.sh"

echo -e "${YELLOW}   Downloading script... ${NC}"
curl -sS -o "$SCRIPT_NAME" "$SCRIPT_URL"

if [[ -f "$SCRIPT_NAME" ]]; then
    chmod +x "$SCRIPT_NAME"
    ./"$SCRIPT_NAME"
else
    exit 1
fi
