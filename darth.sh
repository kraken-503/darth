#!/bin/sh

sleep 1
clear
cat ./art.txt
sleep 1
echo ""

validation() {
    ip="$1"

    if ! echo "$ip" | grep -Eq '^([0-9]{1,3}\.){3}[0-9]{1,3}$'; then
        return 1
    fi

    IFS='.'
    set -- $ip
    for octet in "$@"; do
        if [ "$octet" -lt 0 ] || [ "$octet" -gt 255 ]; then
            return 1
        fi
    done

    return 0
}

apt-get update -y && apt-get install nmap -y

sleep 1

while true; do
  printf "\n Enter an IP address: "
  read target_ip

  if validation "$target_ip"; then
    if ping -c 2 "$target_ip" > /dev/null; then
      echo "\n\t[$target_ip] : host up" 
    else
      echo "\n\t [$target_ip] : host down" && exit
    fi
  else
    echo "[Invalid ip]"
    continue
  fi 

options="
+---------------+----------------------+----------------------------------------------++

| Opt | Technique      | Purpose                                      | Stealth Level  |
+---------------+----------------------+----------------------------------------------++

| 1   | SYN Scan       | Fast, stealthy port scan                     | High           |
| 2   | ACK Scan       | Firewall rule mapping                        | Medium         |
| 3   | Idle Scan      | Zombie-based ultra‑stealth scan              | Very High      |
| 4   | UDP Scan       | Probes UDP services                          | Low            |
| 5   | Fragment Scan  | Evade IDS/firewalls via packet fragments     | High           |
| 6   | NSE Scripts    | Deep enumeration & vulnerability scanning    | Medium         |
| 7   | OS Detection   | Identify target operating system             | Low            |
| 8   | Version Detect | Identify service versions                    | Low            |
| 9   | MAC Spoofing   | Mask hardware identity                       | Medium         |
| 10  | All-Ports Scan | Scan all 65535 ports                         | Low            |
| 11  | Aggressive     | OS, version, script, and traceroute combo     | Low            |
| 12  | Ping Sweep     | ICMP network discovery scan                  | Medium         |
| 13  | Default Script | Safe NSE script checks                       | Medium         |
| 14  | No Ping Scan   | Scan host assuming it is online              | High           |
| 15  | FIN Scan       | Exploit RFC behaviors to bypass firewalls    | High           |
| 16  | Xmas Scan      | Sets FIN, PSH, URG flags for stateless tests | High           |
| 17  | Null Scan      | Sends packets with no TCP flags set          | High           |
| 18  | Window Scan    | Check TCP window sizes for port states       | Medium         |
| 19  | Maimon Scan    | Sends FIN/ACK packets to probe responses     | High           |
| 20  | Decoy Scan     | Mask real IP behind spoofed traffic clones   | High           |
| 21  | Fast Scan      | Scan fewer common ports to save time         | Low            |
| 22  | Top 100 Ports  | Focus strictly on the 100 highest used ports | Low            |
+---------------+----------------------+----------------------------------------------++
"
echo "\n $options"

sleep 1

echo ""
read -p "Select option : " option

case "$option" in 
  1) sleep 1
     sudo nmap -sS "$target_ip" -v 
    ;;
  2) sleep 1
     sudo nmap -sA "$target_ip" -v 
    ;;
  3) sleep 1
     sudo nmap -Pn -sI "$target_ip" -v 
    ;;
  4) sleep 1
     sudo nmap -sU "$target_ip" -v 
    ;;
  5) sleep 1
     sudo nmap -f "$target_ip" -v 
    ;;
  6) sleep 1
     sudo nmap --script vuln malware -T4 "$target_ip" -v 
    ;;
  7) sleep 1
     sudo nmap -O "$target_ip" -v 
    ;;
  8) sleep 1
     sudo nmap -sV "$target_ip" -v 
    ;;
  9) sleep 1
     sudo nmap --spoof-mac Cisco "$target_ip" -v 
    ;;
  10) sleep 1
     sudo nmap -p- "$target_ip" -v 
    ;;
  11) sleep 1
     sudo nmap -A "$target_ip" -v
    ;;
  12) sleep 1
     sudo nmap -sn "$target_ip" -v
    ;;
  13) sleep 1
     sudo nmap -sC "$target_ip" -v
    ;;
  14) sleep 1
     sudo nmap -Pn "$target_ip" -v
    ;;
  15) sleep 1
     sudo nmap -sF "$target_ip" -v
    ;;
  16) sleep 1
     sudo nmap -sX "$target_ip" -v
    ;;
  17) sleep 1
     sudo nmap -sN "$target_ip" -v
    ;;
  18) sleep 1
     sudo nmap -sW "$target_ip" -v
    ;;
  19) sleep 1
     sudo nmap -sM "$target_ip" -v
    ;;
  20) sleep 1
     sudo nmap -D RND:10 "$target_ip" -v
    ;;
  21) sleep 1
     sudo nmap -F "$target_ip" -v
    ;;
  22) sleep 1
     sudo nmap --top-ports 100 "$target_ip" -v
    ;;
  *)
    echo "Invalid option"
    ;;
 esac

done
