from kod import wzrosty_przychodow

def test():
    nazwa_pliku = "przychody.txt"
    try:
        wartosc = wzrosty_przychodow(nazwa_pliku)
        oczekiwania = 5042
        if wartosc == oczekiwania:
            komunikat = "testy OK"
            print("ok")
            return True
        else:
            komunikat = "testy FAIL"
            print("fail")
            return False
    except:
        komunikat = "Cos poszlo nie tak..."
        return False

test()

