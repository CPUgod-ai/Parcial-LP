

import time

def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)

n = 35

inicio = time.time()
resultado = fibonacci(n)
fin = time.time()
tiempo_python = fin - inicio

# tiempo obtenido al correr el programa en C compilado
tiempo_c = 0.070000

print("=" * 45)
print("  COMPARACION DE RENDIMIENTO")
print(f"  Funcion: Fibonacci recursivo  n = {n}")
print("=" * 45)
print(f"  C (compilado)        : {tiempo_c:.6f} seg")
print(f"  Python (interpretado): {tiempo_python:.6f} seg")
print(f"  Resultado fib({n})   : {resultado}")
print(f"\n  Python es {tiempo_python/tiempo_c:.1f}x mas lento que C")
print("=" * 45)
print("\nConclusion:")
print("  C compila a codigo maquina directo.")
print("  Python interpreta cada instruccion en tiempo de ejecucion.")
print("  Con millones de llamadas recursivas la diferencia es muy notoria.")