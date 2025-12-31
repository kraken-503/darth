<div align="center">
  <h2><pre>
░▒█▀▀▄░█▀▀▄░▒█▀▀▄░▀▀█▀▀░▒█░▒█
░▒█░▒█▒█▄▄█░▒█▄▄▀░░▒█░░░▒█▀▀█
░▒█▄▄█▒█░▒█░▒█░▒█░░▒█░░░▒█░▒█
</pre>
</h2>
  <img src="https://github.com/user-attachments/assets/a494b5ed-85eb-47cf-b6f3-360e211ce02c" alt="Logo" width="200">
  <p>A simple nmap automater written in shell script</p>
</div>
<br><br>


 **Table of Contents**
- [Overview](#overview)
- [Requirements](#requirements)
- [Usage](#usage)


<br>

## Overview

It is a shell script that runs one or more Nmap commands automatically, so you don’t have to type them manually each time.​
It typically takes a target (IP address) as input, runs a predefined scan (like a quick scan, full port scan, or service detection).

## Requirements
nmap, ofc
```
sudo apt install nmap -y
sudo pacman -Sy nmap
sudo dnf install nmap -y
brew install nmap
```

## Usage
Keep in mind, almost every scanning vector in this script requires **superuser** permissions.

```
git clone https://github.com/kraken-503/darth.git
cd darth/
chmod +x darth.sh
sudo darth.sh
```

<p align="center">
  <em>Made with ❤️ by kraken-503</em>
</p>

