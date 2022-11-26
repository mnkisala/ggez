def wyciagnij_dane(konfiguracja) -> dict:
    lines = konfiguracja.split('\n')
    curr_section = None
    out = {}
    for line in lines:
        stripped = line.strip()
        if len(stripped) < 1:
            continue
        elif stripped[0] == '[':
            end = stripped.find(']')
            curr_section = stripped[1:end].strip()
            out[curr_section] = {}
        elif '=' in line:
            [k, v] = line.split('=')
            out[curr_section][k.strip()] = v.strip()
    return out
