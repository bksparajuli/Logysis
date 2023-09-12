#!/usr/bin/env python3
import requests
import json
import time

SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/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'
INTERVAL_SECS = 10

def send_slack_message(message):
    payload = {
        'text': message,
    }
    requests.post(SLACK_WEBHOOK_URL, data=json.dumps(payload))

def read_suricata_log():
    with open('/var/log/suricata/fast.log', 'r') as f:
        for line in f:
            fields = line.split('|')
            if len(fields) < 15:
                continue
            alert = json.loads(fields[15])
            message = 'Suricata Alert: {}\n{}'.format(alert['signature'], alert['dest_ip'])
            send_slack_message(message)

if __name__ == '__main__':
    while True:
        read_suricata_log()
        time.sleep(INTERVAL_SECS)

