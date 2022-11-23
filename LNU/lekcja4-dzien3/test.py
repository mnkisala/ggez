from kod import cipher, sprawdz_klucz_z_gry

def test():
    szyfr = "To jest test, jezeli to zadziala, wszystko zadziala!"
    try:
        wartosc = cipher(szyfr, 4)
        oczekiwania = "Xs niwx xiwx, nidipm xs dehdmepe, awdcwxos dehdmepe!"
        klucz_z_gry_od_uzytkownika = sprawdz_klucz_z_gry()
        poprawny_klucz_z_gry = 3306
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

