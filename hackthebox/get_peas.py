# Downloads the latest version of linpeas and winpeas from GitHub

import requests, re, os

URL = "https://github.com/"
RELEASE = "carlospolop/PEASS-ng/releases"

# linpeas.sh
req = requests.get(URL + RELEASE).text
link = re.findall(r'".*linpeas.sh"', req)[0]
link = link.replace('"', '')

req = requests.get(URL + link).text

open("linpeas.sh", "wb").write(req.encode())
print("[+] linpeas downloaded")

# winPEASx64.exe
req = requests.get(URL + RELEASE).text
link = re.findall(r'".*winPEASx64.exe"', req)[0]
link = link.replace('"', '')

req = requests.get(URL + link).content
open("winpeas.exe", "wb").write(req)
print("[+] winpeas downloaded")

