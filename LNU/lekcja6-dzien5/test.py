import kod
import exampleimpl


def test():
    fcontent = open("config.cfg")
    content = fcontent.read()
    reference = exampleimpl.wyciagnij_dane(content)
    fcontent.close()

    try:
        wartosc = kod.wyciagnij_dane(content)
        if wartosc == reference:
            komunikat = "testy OK, wyjscie: " + str(wartosc)
            print(komunikat)
            return True
        else:
            komunikat = "testy FAIL, wyjscie: " + str(wartosc)
            print(komunikat)
            return False
    except:
        komunikat = "Cos poszlo nie tak..." + e
        print(komunikat)
        return False


test()
