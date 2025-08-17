#!/bin/bash

# Barvy
GREEN='\033[0;32m'
RED='\033[0;31m'
GRAY='\033[0;37m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

clear

# ASCII Art logo
echo -e "${BLUE}"
echo "███████╗ █████╗  ██████╗███████╗███╗   ███╗██╗███╗   ██╗███████╗██████╗ "
echo "██╔════╝██╔══██╗██╔════╝██╔════╝████╗ ████║██║████╗  ██║██╔════╝██╔══██╗"
echo "█████╗  ███████║██║     █████╗  ██╔████╔██║██║██╔██╗ ██║█████╗  ██████╔╝"
echo "██╔══╝  ██╔══██║██║     ██╔══╝  ██║╚██╔╝██║██║██║╚██╗██║██╔══╝  ██╔══██╗"
echo "██║     ██║  ██║╚██████╗███████╗██║ ╚═╝ ██║██║██║ ╚████║███████╗██║  ██║"
echo "╚═╝     ╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"
sleep 0.7

# Progress bar
echo -n "[*] Initializing miner: ["
for i in {1..30}; do
    echo -n "#"
    sleep 0.03
done
echo -e "] ${GREEN}OK${NC}"
sleep 0.4

# Fake loading
boost_msgs=(
    "Loading firmware..."
    "Activating cores..."
    "Injecting BIOS hooks..."
    "Optimizing vector paths..."
    "Calibrating thermal sensors..."
    "Establishing connection with GPU..."
)

for msg in "${boost_msgs[@]}"; do
    echo -e "${YELLOW}[BOOT] ${msg}${NC}"
    sleep 0.4
done

sleep 0.7
echo -e "${CYAN}[*] Connected to pool.kaspafake.io:3030 – mining started!${NC}"
sleep 0.5

# Hlavička
echo -e "${GRAY}"
echo "+--------------------------------------------------------------------+"
echo "| Time     | Speed   | Status    | Diff  | Temp | Job Source         |"
echo "+--------------------------------------------------------------------+"
echo -e "${NC}"

# Hlavní smyčka
while true; do
    timestamp=$(date +%H:%M:%S)
    hashrate=$(shuf -i 390-420 -n 1)
    diff=$(shuf -i 1000-6000 -n 1)
    temp=$(shuf -i 60-92 -n 1)
    acc_or_rej=$(shuf -e "accepted" "accepted" "accepted" "rejected" -n 1)
    job_from_pool=$(shuf -e "pool.kaspafake.io" "fakepool.io" "kaspa123.net" -n 1)

    # Barvy podle výsledku
    status_col=$([ "$acc_or_rej" == "accepted" ] && echo "${GREEN}accepted${NC}" || echo "${RED}rejected${NC}")
    temp_col=$([ "$temp" -gt 85 ] && echo "${RED}${temp}°C${NC}" || echo "${CYAN}${temp}°C${NC}")

    printf "| ${timestamp} | ${hashrate} H/s | %s | %4d | %4s | %-18s |\n" "$status_col" "$diff" "$temp_col" "$job_from_pool"

    # Události
    if (( RANDOM % 7 == 0 )); then
        echo -e "${YELLOW}>> New job from pool: ${job_from_pool}${NC}"
    fi

    if (( RANDOM % 11 == 0 )); then
        echo -e "${RED}!! WARNING: GPU temperature high (${temp}°C) – throttling...${NC}"
    fi

    if (( RANDOM % 9 == 0 )); then
        msg=$(shuf -e "Hashrate boost applied" "Latency reduced" "Cooling profile adjusted" "Memory timing tuned" -n 1)
        echo -e "${BLUE}[BOOST] ${msg}${NC}"
    fi

    sleep 1
done

