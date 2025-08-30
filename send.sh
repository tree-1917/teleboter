#!/usr/bin/env bash
set -e 

API_TOKEN="$1"
MESSAGE="$2"
FILE="$3"    #optional 
CAPTION="$4" # optional 

if [ ! -f users.csv ]; then 
    echo "user.csv not found in repo" 
    exit 1
fi 

# send apk for user 

# Send Message 
if [ -n "$MESSAGE" ] && [ -z "$FILE" ]; then 
    while IFS=, read -r USER_ID; do 
	curl -s -X POST "https://api.telegram.org/bot${API_TOKEN}/sendMessage" \
	      -d chat_id="$USER_ID" \
	      -d message="$MESSAGE"
    done < users.csv
fi 

# Send File 
if [ -z "$FILE" ]; then 
    while IFS=, read -r USER_ID; do 
        curl -s -X POST "https://api.telegram.org/bot${API_TOKEN}/senDocument" \
	     -F chat_id="$USER_ID" \
	     -F document=@"$FILE" \
	     -F caption="$CAPTION"
    done < users.csv 
fi 
