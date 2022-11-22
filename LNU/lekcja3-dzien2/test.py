from kod import xor

def test():
    klucz1 = "a73232f36a2ce52f98ac3d8e7f8cd20a"
    klucz2 = "98a72b80b723a097ffc5d7c801e26299"
    try:
        wartosc = xor(klucz1, klucz2)
        oczekiwania = [(ord(a) ^ ord(b)) for a,b in zip(klucz1, klucz2)]
        if wartosc == oczekiwania:
            komunikat = "testy OK, wyjscie: " + str(wartosc)
            print(komunikat)
            return True
        else:
            komunikat = "testy FAIL, wyjscie: " + str(wartosc)
            print(komunikat)
            return False
    except:
        komunikat = "Cos poszlo nie tak..."
        print(komunikat)
        return False

test()

