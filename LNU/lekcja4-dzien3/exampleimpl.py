def cipher(szyfr, przesuniecie):
    out = ""
    for char in szyfr:
        if char.isupper():
            out += chr((ord(char) + przesuniecie - 65) % 26 + 65)
        elif char.islower():
            out += chr((ord(char) + przesuniecie - 97) % 26 + 97)
        else:
            out += char
    return out

