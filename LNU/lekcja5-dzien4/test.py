from kod import wzrosty_przychodow, sprawdz_klucz_z_gry


def test():
    nazwa_pliku = "przychody.txt"
    try:
        wartosc = wzrosty_przychodow(nazwa_pliku)
        oczekiwania = 5042
        klucz_z_gry_od_uzytkownika = sprawdz_klucz_z_gry()
        poprawny_klucz_z_gry = 2131
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
