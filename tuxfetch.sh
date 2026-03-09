#!/bin/sh

# colors
RESET='\033[0m'
BOLD='\033[1m'
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
MAGENTA='\033[35m'

# info
USER=$(whoami)
HOST=$(hostname)
OS=$(uname -s)
KERNEL=$(uname -r)
ARCH=$(uname -m)
UPTIME=$(uptime | sed 's/.*up //' | sed 's/,.*//')
SHELL=$(basename "$SHELL")
DATE=$(date "+%Y-%m-%d %H:%M")

# CPU
CPU=$(grep 'model name' /proc/cpuinfo 2>/dev/null | head -1 | cut -d: -f2 | sed 's/^ //' || sysctl -n machdep.cpu.brand_string 2>/dev/null)

# RAM
if [ -f /proc/meminfo ]; then
    MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print int($2/1024) " MB"}')
    MEM_FREE=$(grep MemAvailable /proc/meminfo | awk '{print int($2/1024) " MB"}')
    RAM="$MEM_FREE free / $MEM_TOTAL total"
else
    RAM="N/A"
fi

# ASCII art and system info
printf "${CYAN}                         ${RESET}  ${BOLD}${GREEN}$USER${RESET}@${BOLD}${GREEN}$HOST${RESET}\n"
printf "${CYAN}        _nnnn_           ${RESET}  ${CYAN}OS:${RESET}      $OS $ARCH\n"
printf "${CYAN}       dGGGGMMb          ${RESET}  ${CYAN}Kernel:${RESET}  $KERNEL\n"
printf "${CYAN}      @p~qp~~qMb         ${RESET}  ${CYAN}Uptime:${RESET}  $UPTIME\n"
printf "${CYAN}      M|@||@) M|         ${RESET}  ${CYAN}Shell:${RESET}   $SHELL\n"
printf "${CYAN}      @,----.JM|         ${RESET}  ${CYAN}CPU:${RESET}     $CPU\n"
printf "${CYAN}     JS^\\__/  qKL        ${RESET}  ${CYAN}RAM:${RESET}     $RAM\n"
printf "${CYAN}    dZP        qKRb      ${RESET}  ${CYAN}Date:${RESET}    $DATE\n"
printf "${CYAN}   dZP          qKKb     ${RESET}\n"
printf "${CYAN}  fZP            SMMb    ${RESET}\n"
printf "${CYAN}  HZM            MMMM    ${RESET}\n"
printf "${CYAN}  FqM            MMMM    ${RESET}\n"
printf "${CYAN} __| '.        |\\dS'qML  ${RESET}\n"
printf "${CYAN} |    \`.       | \`' \\Zq  ${RESET}\n"
printf "${CYAN}_)      \\.___.,|     .'  ${RESET}\n"
printf "${CYAN}\\____   )MMMMMP|   .'    ${RESET}\n"
printf "${CYAN}     \`-'       \`--' hjm  ${RESET}\n"

# color bar
printf "\n  "
for color in 30 31 32 33 34 35 36 37; do
    printf "\033[${color}m###${RESET}"
done
printf "\n\n"
