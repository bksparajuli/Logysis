#!/bin/bash

# Set Slack webhook URL and channel
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"
SLACK_CHANNEL="#fyp"

# Send notification when Suricata starts
curl -s -X POST -H 'Content-type: application/json' --data "{\"text\":\"Suricata started\"}" "$SLACK_WEBHOOK_URL"

# Monitor the fast.log file using inotifywait
while inotifywait -e modify /var/log/suricata/fast.log; do
  # Get the last line of the fast.log file
  line=$(tail -n 1 /var/log/suricata/fast.log)

  # Parse Suricata log line
  timestamp=$(echo "$line" | awk '{print $1}')
  classification=$(echo "$line" | awk -F 'Classification: ' '{for (i=2; i<=NF; i++) {split($i,a,"]"); print a[1]}}')
  description=$(echo "$line" | awk -F '[[0-9]+:[0-9]+:[0-9]+]' '{gsub("\\[\\*\\*\\]", "", $2); split($2, a, "\\["); print a[1]}')
  src_ip=$(echo "$line" | awk -F '{(TCP|UDP|ICMP)} | ->' '{print $2}')
  dest_ip=$(echo "$line" | awk -F '->' '{print $2}')
  priority=$(echo "$line" | awk -F '[][]' '/Priority:/ {for (i=1; i<=NF; i++) {if ($i ~ /Priority:/) {split($i,a," "); split(a[2],b,"]"); print b[1]}}}')

  # Build Slack message payload
  payload="{
    \"channel\": \"$SLACK_CHANNEL\",
    \"text\": \"Suricata alert triggered:\",
    \"attachments\": [
      {
        \"fallback\": \"Suricata alert triggered: $description\",
        \"color\": \"danger\",
        \"fields\": [
          {
            \"title\": \"Timestamp\",
            \"value\": \"$timestamp\",
            \"short\": true
          },
          {
            \"title\": \"Classification\",
            \"value\": \"$classification\",
            \"short\": true
          },
          {
            \"title\": \"Description\",
            \"value\": \"$description\",
            \"short\": false
          },
          {
            \"title\": \"Source IP\",
            \"value\": \"$src_ip\",
            \"short\": true
          },
          {
            \"title\": \"Destination IP\",
            \"value\": \"$dest_ip\",
            \"short\": true
          },
          {
            \"title\": \"Priority\",
            \"value\": \"$priority\",
            \"short\": true
          }
        ]
      }
    ]
  }"

  # Send Slack message via webhook
  curl -s -X POST -H 'Content-type: application/json' --data "$payload" "$SLACK_WEBHOOK_URL"
done

