#!/bin/bash

URL="http://web"
LOG_FILE="/var/log/web_server_status.log"

RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" $url)

if [[ "$RESPONSE_CODE" != 2* && "$RESPONSE_CODE" != 3* ]]; then
    
    echo "Web server is not responding at $(date)" >> $LOG_FILE
fi

