def wzrosty_przychodow(plik):
    poprzedni_przychod = 999999999
    wzrosly = 0
    with open(plik) as plik:
        for linia in plik:
            przychod = int(linia.strip().split(":")[1])
            if przychod > poprzedni_przychod:
                wzrosly += 1
            poprzedni_przychod = przychod
    return wzrosly

