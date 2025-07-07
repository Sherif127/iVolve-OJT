# 🐚 Lab 1 : Shell Scripting with crontab

## 🎯 Project Objective

Automate daily MySQL database backups using a shell script and schedule it with `cron`.

### Key Goals:
- Enable consistent and reliable backups.
- Store backups with organized date-based filenames.
- Run the backup process automatically with no manual intervention.

---

## ⚙️ Prerequisites

Make sure the following are available on your system:

- Linux OS (Ubuntu, CentOS, etc.)
- MySQL Server installed and configured
- Bash shell access
- Sudo privileges or a user with `cron` and MySQL access

---

## 🚀 Setup Guide

### 1️⃣ Install MySQL Server

**For CentOS/RHEL:**
```bash
sudo dnf update
sudo dnf install mysql-server -y

```

  

---

  

### 2️⃣ Create Backup Directory

  

```bash

mkdir  -p  /opt/mysql_backups

```

  

---

  

### 3️⃣ Write the Shell Script

  

Create a shell script: `mysql_backup.sh`:

```bash

vim  mysql_backup.sh

```

  

add the following content:

  

```bash
#!/bin/bash

# Set backup variables
BACKUP_DIR="/opt/mysql_backups"
DATE=$(date +%F)
DB_NAME="your_db_name"
DB_USER="your_user"
DB_PASS="your_password"
BACKUP_FILE="$BACKUP_DIR/MySQL_backup_$DATE.sql"
LOG_FILE="$HOME/mysql_backup.log"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check write permission to /var/log if used 
if [ ! -w "$LOG_FILE" ] && [[ "$LOG_FILE" == "/var/log/"* ]]; then
    echo -e "${RED}Permission denied to write to $LOG_FILE. Please run as sudo or use a user-writable path.${NC}"
    exit 1
fi

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Run MySQL dump
mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_FILE"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "$(date): Backup succeeded: $BACKUP_FILE" | tee -a "$LOG_FILE"
    echo -e "${GREEN}✔ Backup completed successfully.${NC}"
else
    echo "$(date): Backup failed!" | tee -a "$LOG_FILE"
    echo -e "${RED}✖ Backup failed! Check log: $LOG_FILE${NC}"
    exit 1
fi

```

  

> 🔐 **Note:** Replace `YourPassword` with the actual MySQL root password or use a secure method like a `.my.cnf` file.

  

Make the script executable:

```bash

chmod  +x  mysql_backup.sh

```

  

---

  

### 4️⃣ Schedule with Cron

  

Open the crontab editor:

  

```bash

crontab  -e

```

  

Add the following line to schedule the backup to run every day at 5:00 PM:

```

0 17 * * * /absolute/path/to/mysql_backup.sh

```
![Image](https://github.com/user-attachments/assets/ced34718-3bb1-4622-a931-2e915d8c8ef1)
  

You can find your current path using:

```bash

pwd

```

## 📦 Outputs

  

- Backup files are saved in the `opt/mysql_backups` directory.

- Filenames will follow the format: `MySQL_backup_YYYY-MM-DD.sql`

  

Example:

```

MySQL_backup_2025-06-23.sql

```

 ![Image](https://github.com/user-attachments/assets/609cff60-bd73-4b6b-aaa0-560d509af421)

---

  

## ✅ Benefits

- Automatic daily backups

- Simple and effective

- Organized by date

- Easy to restore from

---