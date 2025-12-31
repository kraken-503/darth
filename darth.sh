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
    echo "[Invalid ip"]
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
+---------------+----------------------+----------------------------------------------++
"
echo "\n $options"

sleep 1

echo ""
read -p "Select option : " option

case "$option" in 
  1) sleep 1
     nmap -sS "$target_ip" -v 
    ;;
  2) sleep 1
     nmap -sA "$target_ip" -v 
    ;;
  3) sleep 1
     nmap -Pn -sI "$target_ip" -v 
    ;;
  4) sleep 1
     nmap -sU "$target_ip" -v 
    ;;
  5) sleep 1
     nmap -f "$target_ip" -v 
    ;;
  6) sleep 1
     nmap --script vuln malware -T4 "$target_ip" -v 
    ;;
  7) sleep 1
     nmap -O "$target_ip" -v 
    ;;
  8) sleep 1
     nmap -sV "$target_ip" -v 
    ;;
  9) sleep 1
     nmap --spoof-mac Cisco "$target_ip" -v 
    ;;
  10) sleep 1
     nmap -p- "$target_ip" -v 
    ;;
  *)
    echo "Invalid option"
    ;;
 esac

done
