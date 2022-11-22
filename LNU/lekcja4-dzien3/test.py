from kod import cipher

def test():
    szyfr = "To jest test, jezeli to zadziala, wszystko zadziala!"
    try:
        wartosc = cipher(szyfr, 4)
        oczekiwania = "Xs niwx xiwx, nidipm xs dehdmepe, awdcwxos dehdmepe!"
        if wartosc == oczekiwania:
            komunikat = "testy OK"
            print(komunikat)
            return True
        else:
            print(wartosc)
            komunikat = "testy FAIL"
            print(komunikat)
            return False
    except:
        komunikat = "Cos poszlo nie tak..."
        print(komunikat)
        return False

test()

