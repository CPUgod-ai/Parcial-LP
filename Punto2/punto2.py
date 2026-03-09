def afd_id(cadena):
    if len(cadena) == 0:
        return False

    
    if not cadena[0].isalpha():
        return False

    
    for c in cadena[1:]:
        if not c.isalpha() and not c.isdigit():
            return False

    return True



casos = [
    ("variable",   True),
    ("var123",     True),
    ("A",          True),
    ("hola_mundo", False),  
    ("123abc",     False),  
    ("",           False),  
    ("x1y2z3",     True),
]

for cadena, esperado in casos:
    r = afd_id(cadena)
    ok = "OK" if r == esperado else "FALLO"
    print(f"  [{ok}] '{cadena}' -> {'valido' if r else 'invalido'}")