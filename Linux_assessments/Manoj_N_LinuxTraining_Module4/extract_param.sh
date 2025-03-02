#!/bin/bash

INPUT_FILE="input.txt"
OUTPUT_FILE="output.txt"

rm -f "$OUTPUT_FILE"
while IFS= read -r line; do
   
    if [[ "$line" == *"frame.time"* || "$line" == *"wlan.fc.type"* || "$line" == *"wlan.fc.subtype"* ]]; then
        echo "$line" >> "$OUTPUT_FILE"
    fi
done < "$INPUT_FILE"
