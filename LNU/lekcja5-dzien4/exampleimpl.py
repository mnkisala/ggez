"""
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
"""

def przychod_z_linii(linia):
    return int(linia.strip().split(":")[1])

def wzrosty_przychodow(plik):
    wzrosly = 0
    with open(plik) as plik:
        linie = plik.readlines()
        for i in range(1, len(linie)):
            if przychod_z_linii(linie[i]) > przychod_z_linii(linie[i -1]):
                wzrosly += 1
    return wzrosly