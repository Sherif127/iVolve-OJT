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
NC='\033[0m' 

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
