def xor(key1, key2):
    #return [(ord(a) ^ ord(b)) for a,b in zip(key1, key2)]
    final = []
    for i in range(len(key1)):
        final.append(ord(key1[i]) ^ ord(key2[i]))
    return final

