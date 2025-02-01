#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <source_directory> <backup_directory> <file_extension>"
    exit 1
fi

SOURCE_DIR="$1"
BACKUP_DIR="$2"
FILE_EXT="$3"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory does not exist."
    exit 1
fi

if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR" || { echo "Error: Failed to create backup directory."; exit 1; }
fi

FILES=($SOURCE_DIR/*$FILE_EXT)


if [ "${#FILES[@]}" -eq 0 ]; then
    echo "No files with extension $FILE_EXT found in source directory."
    exit 0
fi

export BACKUP_COUNT=0
TOTAL_SIZE=0

for FILE in "${FILES[@]}"; do
    FILENAME=$(basename "$FILE")
    DEST_FILE="$BACKUP_DIR/$FILENAME"
    FILE_SIZE=$(stat -c %s "$FILE")

        if [ -e "$DEST_FILE" ]; then
        if [ "$FILE" -nt "$DEST_FILE" ]; then
            cp "$FILE" "$DEST_FILE"
        fi
    else
        cp "$FILE" "$DEST_FILE"
    fi
    
    echo "Backed up: $FILENAME ($FILE_SIZE bytes)"
    TOTAL_SIZE=$((TOTAL_SIZE + FILE_SIZE))
    BACKUP_COUNT=$((BACKUP_COUNT + 1))    
done

REPORT_FILE="$BACKUP_DIR/backup_report.log"
echo "Backup Summary:" > "$REPORT_FILE"
echo "Total files processed: $BACKUP_COUNT" >> "$REPORT_FILE"
echo "Total size of files backed up: $TOTAL_SIZE bytes" >> "$REPORT_FILE"
echo "Backup directory: $BACKUP_DIR" >> "$REPORT_FILE"
echo "Backup completed. Report saved in $REPORT_FILE"
