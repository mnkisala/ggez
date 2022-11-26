def wyciagnij_dane(konfiguracja: str) -> dict:
    lines = konfiguracja.split('\n')
    out = {}
    for line in lines:
        if '=' in line:
            [k, v] = line.split('=')
            out[k.strip()] = v.strip()
    return out
