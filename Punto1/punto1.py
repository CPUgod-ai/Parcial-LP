import re

patron= r'^[kqrbnp]{1,3}(->[a-hkq]{1,2}[1-8]?|X[kqrbnp]{1,3})$'

def verificar_movimiento(mov):
    mov = mov.replace(' ', '')
    if re.match(patron, mov):
        print(f"'{mov}' -> VALIDO")
    else:
        print(f"'{mov}' -> INVALIDO")


verificar_movimiento("p->k4")
verificar_movimiento("kbp X qn")
verificar_movimiento("r->kb3")
verificar_movimiento("nXp")
verificar_movimiento("p-k4")
verificar_movimiento("->k4")