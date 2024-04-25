# main.py -- put your code here!
print("hello main")


    res = urequests.get("http://192.168.10.39:9087/ping", timeout=3)
    print(res)
    print(res.content)
    jsonresults = json.loads(res.content)
    print(jsonresults)