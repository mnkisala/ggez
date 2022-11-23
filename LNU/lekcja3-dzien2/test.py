from kod import xor, sprawdz_klucz_z_gry

def test():
    klucz1 = "a73232f36a2ce52f98ac3d8e7f8cd20a"
    klucz2 = "98a72b80b723a097ffc5d7c801e26299"
    try:
        wartosc = xor(klucz1, klucz2)
        oczekiwania = [(ord(a) ^ ord(b)) for a,b in zip(klucz1, klucz2)]
        klucz_z_gry_od_uzytkownika = sprawdz_klucz_z_gry()
        poprawny_klucz_z_gry = 1883
        if wartosc == oczekiwania and klucz_z_gry_od_uzytkownika == poprawny_klucz_z_gry:
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

