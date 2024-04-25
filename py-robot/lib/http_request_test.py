import urequests
import json
# res = urequests.post('https://XXX.amazonaws.com/XXX/XXX', data=json.dumps(myPostedData))
# jsonresults = json.loads(res.content)

res = urequests.get("http://192.168.10.39:9087/ping", timeout=3)
print(res)
print(res.content)
jsonresults = json.loads(res.content)
print(jsonresults)
