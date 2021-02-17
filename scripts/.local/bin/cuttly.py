#! /usr/bin/python3

import sys
import subprocess
import urllib
import requests

key = subprocess.check_output("secret-tool lookup cuttly api", shell=True).decode('utf-8')
url = urllib.parse.quote(sys.argv[1])
data = requests.get('http://cutt.ly/api/api.php?key={}&short={}'.format(key, url))
print(data.json()['url']['shortLink'])
