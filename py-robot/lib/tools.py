import struct


class StringTool():
    def __init__(self, string):
        self.string = string

    def replace(string, inStr, chgStr):
        tempStr = str()
        _chgStr = chgStr
        for i in range(0, len(string)):
            if str(string[i]) == inStr:
                if chgStr == '' or chgStr == "" or chgStr == None:
                    pass
                else:
                    tempStr = tempStr + _chgStr
            else:
                tempStr = tempStr + string[i]
        return tempStr

    def rindex(string, indexStr):
        r_index = 0
        for i in range(0, len(string)):
            if string[i] == indexStr:
                if i >= r_index:
                    r_index = i
        return r_index

    def join(string, Dict):
        for i in range(0, len(Dict)):
            string = string + Dict[i]
        return string