<div align="center">

# GhostMode

![Bash](https://img.shields.io/badge/Shell_Script-Bash-4EAA25?style=flat&logo=gnu-bash&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)
![Platform](https://img.shields.io/badge/Platform-Linux-orange)

<p>
  <strong>An OpSec-focused anti-forensics tool to clear system traces on Linux.</strong>
</p>

[Report Bug](https://github.com/egetones/ghostmode/issues) · [Request Feature](https://github.com/egetones/ghostmode/issues)

</div>

---

## Description

**GhostMode** is a Bash script designed for Operational Security (OpSec) purposes. When working on a Linux machine (specifically optimized for **Fedora**), users leave behind unintentional traces such as command history, image thumbnails, and cache files.

GhostMode automates the process of "cleaning house." Unlike standard deletion (`rm`), this tool utilizes **secure deletion methods** (like `shred`) where possible to prevent data recovery by forensic tools.

### Key Features

* Secure History Wipe:** Overwrites `.bash_history` with random data before deletion to prevent recovery.
* Anti-Forensics:** Deletes cached image thumbnails that prove which photos were viewed.
* Package Cleanup:** Clears DNF/APT cache to hide recently installed tool traces.
* Log Zeroing:** Truncates system logs (`/var/log`) without deleting the files, maintaining system stability while hiding activity.
* Distro Agnostic:** Works on Fedora, Debian, Ubuntu, and Kali Linux.

---

## Usage

**Note:** This script requires `root` privileges to clean system-level logs.

1. **Clone the repository:**
   ```bash
   git clone https://github.com/egetones/ghostmode.git
   cd ghostmode
   ```

2. **Make the script executable:**
   ```bash
   chmod +x ghostmode.sh
   ```

3. **Run as root:**
   ```bash
   sudo ./ghostmode.sh
   ```

---

## Technical Insight: `rm` vs `shred`

Why do we use `shred` for history files?

* **Standard `rm`:** Only removes the pointer to the file. The actual data remains on the disk until overwritten by new data. Forensic tools can easily recover this.
* **`shred`:** Overwrites the file content with random zeros and ones multiple times (passes) before deleting it. This makes magnetic recovery nearly impossible.

---

## ⚠️ Disclaimer

This tool is for **educational purposes and self-protection** only. Cleaning logs on a system you do not own (e.g., corporate or university servers) may be considered tampering with evidence and is illegal. Use responsibly on your own machines.

---

## License

Distributed under the MIT License. See `LICENSE` for more information.
Çrş 15 Nis 2026 22:15:54 +03
