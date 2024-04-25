import btree

CORE_STORAGE = "myenv"


# Do this only once, it will overwite a previous file with a new one if it exists
def init():
    with open(CORE_STORAGE, 'w+b') as f:
        db = btree.open(f)
        db[b"MODE"] = b"INIT"
        db.close()


def get(item):
    value = None
    with open(CORE_STORAGE, 'r+b') as f:
        db = btree.open(f)
        b_item = item.encode('ascii')
        value = db.get(b_item)
        if value:
            value = value.decode('ascii')
        db.close()
    return value


def put(item, value):
    b_item = None
    b_value = None
    try:
        b_item = item.encode('ascii')
        b_value = value.encode('ascii')
    except AttributeError:
        print("storage items and values must be ascii strings")
        return False

    if b_item and b_value:
        with open(CORE_STORAGE, 'r+b') as f:
            db = btree.open(f)
            db[b_item] = b_value
            db.flush()
            db.close()
        return True


if __name__ == '__main__':
    init()
    ssid_str = "SSID"
    ssid = get(ssid_str)
    print(ssid)
    if ssid is None:
        put("SSID", "My SSID")
    ssid = get(ssid_str)
    print(ssid)
