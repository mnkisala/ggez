from kod import wzrosty_przychodow

def test():
    nazwa_pliku = "przychody.txt"
    try:
        wartosc = wzrosty_przychodow(nazwa_pliku)
        oczekiwania = 5042
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

