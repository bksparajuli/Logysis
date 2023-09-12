#!/usr/bin/env python

import requests

bot_token = '6249026661:AAGhR0ae5oKlVW_5Wj_rOUw6GurPy94dBXg'
chat_id = '6249026661'
message = "Fail2Ban has detected a security breach on your system"

url = f"https://api.telegram.org/bot{bot_token}/sendMessage"
data = {"chat_id": chat_id, "text": message}

requests.post(url, data=data)

