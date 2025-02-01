#!/bin/bash

ERROR_LOG="errors.log"

display_help() {
cat << EOF
Usage: $0 [OPTIONS]

Options:
  -d <directory>  Recursively search for a keyword in a directory.
  -f <file>       Search for a keyword in a specific file.
  -k <keyword>    Specify the keyword to search for.
  --help          Display this help menu.

Example Usage:
  # Recursively search a directory for a keyword
  $0 -d logs -k error

  # Search for a keyword in a file
  $0 -f script.sh -k TODO

  # Display the help menu
  $0 --help
EOF
}

search_directory() {
    local dir="$1"
    local keyword="$2"

    # Check if directory exists
    if [[ ! -d "$dir" ]]; then
        echo "Error: Directory '$dir' not found." | tee -a "$ERROR_LOG"
        exit 1
    fi

    # Recursively search for keyword
    grep -r "$keyword" "$dir" 2>>"$ERROR_LOG" || echo "No matches found for '$keyword' in '$dir'."
}

search_file() {
    local file="$1"
    local keyword="$2"

    if [[ ! -f "$file" ]]; then
        echo "Error: File '$file' not found." | tee -a "$ERROR_LOG"
        exit 1
    fi
    grep "$keyword" "$file" <<< "$(cat "$file")" || echo "No matches found for '$keyword' in '$file'."
}


while getopts "d:f:k:-:" opt; do
    case "$opt" in
        d) DIRECTORY="$OPTARG" ;;
        f) FILE="$OPTARG" ;;
        k) KEYWORD="$OPTARG" ;;
        -)
            case "${OPTARG}" in
                help) display_help; exit 0 ;;
                *) echo "Invalid option: --${OPTARG}" | tee -a "$ERROR_LOG"; exit 1 ;;
            esac ;;
        ?) display_help; exit 1 ;;
    esac
done
if [[ -n "$KEYWORD" && ! "$KEYWORD" =~ ^[a-zA-Z0-9_]+$ ]]; then
    echo "Error: Invalid keyword format." | tee -a "$ERROR_LOG"
    exit 1
fi

if [[ -n "$DIRECTORY" && -n "$KEYWORD" ]]; then
    search_directory "$DIRECTORY" "$KEYWORD"
elif [[ -n "$FILE" && -n "$KEYWORD" ]]; then
    search_file "$FILE" "$KEYWORD"
else
    echo "Error: Invalid or missing arguments." | tee -a "$ERROR_LOG"
    display_help
    exit 1
fi
