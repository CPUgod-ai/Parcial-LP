# Parcial - LP
Estos son los puntos que desarrollé para el parcial de compiladores. El lenguaje principal fue Python y C según lo pedía cada punto.

---

## Punto 1 - AFD para movimientos de ajedrez

La idea era definir una expresión regular para reconocer movimientos de ajedrez en notación algebraica antigua como `p->k4` o `kbp X qn` e implementar un AFD que los valide.

La expresión regular que definí fue:
```
[kqrbnp]{1,3} -> [a-hkq]{1,2}[1-8]?
[kqrbnp]{1,3} X  [kqrbnp]{1,3}
```

Las piezas pueden tener entre 1 y 3 letras porque en esta notación se usa el lado del tablero, por ejemplo `kb` es el alfil del rey y `kbp` es el peón en esa columna. Los movimientos van con flecha `->` seguido de la casilla destino, y las capturas van con `X` entre las dos piezas.

Hice dos versiones: una usando la librería `re` de Python que queda muy corta, y otra implementando el AFD manualmente recorriendo la cadena carácter por carácter con un índice `i` y validando cada parte por separado.

**Correr:**
```bash
python3 punto1_ajedrez.py
```

---

## Punto 2 - AFD para identificadores

AFD que valida identificadores según la expresión regular `[A-Za-z][A-Za-z0-9]*`. La regla es simple: el primer carácter tiene que ser una letra y los siguientes pueden ser letras o dígitos. Cosas como `123abc` o `hola_mundo` no son válidas porque la primera empieza con número y la segunda tiene guion bajo que no está en la expresión regular.

El AFD tiene tres estados: el inicial, uno de aceptación cuando ya leyó la primera letra, y uno de error cuando encuentra un carácter inválido. Lo implementé recorriendo la cadena con `isalpha()` e `isdigit()` de Python que hacen exactamente lo que necesitaba.

**Correr:**
```bash
python3 punto2_id_afd.py
```

---

## Punto 3 - Comparación C vs Python

Comparé el rendimiento de C (compilado) contra Python (interpretado) usando Fibonacci recursivo con `n=35`. Escogí Fibonacci recursivo porque genera alrededor de 29 millones de llamadas recursivas, lo que hace que la diferencia de tiempo sea muy notoria.

El resultado fue que C tardó `0.07 segundos` y Python tardó casi `0.92 segundos`, o sea Python fue unas 13 veces más lento. La razón es que C se compila directo a código máquina y el procesador lo ejecuta sin intermediarios, mientras que Python interpreta cada instrucción en tiempo de ejecución, y con millones de llamadas recursivas ese overhead se acumula mucho.

**Correr:**
```bash
gcc fibonacci.c -o fibonacci_c
./fibonacci_c
python3 punto3_comparacion.py
```

---

## Punto 5 - Calculadora con Flex y Bison

Calculadora en C que usa Flex para el análisis léxico y Bison para el análisis sintáctico. Soporta las cuatro operaciones básicas y raíz cuadrada con la sintaxis `sqrt(numero)`. La entrada la lee desde un archivo de texto y los resultados los imprime en consola.

Flex se encarga de reconocer los tokens: números, operadores, paréntesis y la palabra `sqrt`. Bison define la gramática con sus reglas de precedencia, `*` y `/` tienen más prioridad que `+` y `-` usando `%left`.

La raíz cuadrada la calculé con Newton-Raphson. El método arranca con `x = n/2` como estimación inicial y en cada iteración aplica `x = 0.5 * (x + n/x)` hasta que la diferencia entre una iteración y la siguiente sea menor a `1e-10`. Para `sqrt(25)` converge en pocas iteraciones y da exactamente 5.

**Requisitos:**
```bash
sudo apt-get install flex bison gcc
```

**Compilar y correr:**
```bash
bison -d calculadora.y
flex calculadora.l
gcc calculadora.tab.c lex.yy.c -o calculadora -lm
./calculadora entrada.txt
```

---

## Punto 6 - Fibonacci con ANTLR

Programa en Python que usa ANTLR4 para parsear una expresión con la forma `FIBO(n)` y calcular la secuencia de Fibonacci hasta ese número.

La gramática en `Fibo.g4` define que la entrada válida es exactamente `FIBO(` + un número + `)`. ANTLR genera automáticamente el lexer y el parser a partir de esa gramática. En `main.py` se lee la entrada del usuario, se pasa por el lexer y parser de ANTLR, se extrae el número del árbol sintáctico con `tree.NUMERO().getText()` y se calcula la secuencia.

El cálculo del Fibonacci lo hice iterativo con una lista: arranca con `[0, 1]` y en cada paso agrega la suma de los dos últimos elementos hasta llegar a `n` términos.

**Requisitos:**
```bash
pip install antlr4-python3-runtime==4.13.1
sudo apt-get install default-jdk
```

**Generar lexer y parser:**
```bash
java -jar antlr-4.13.1-complete.jar -Dlanguage=Python3 Fibo.g4
```

**Correr:**
```bash
python3 main.py
```

**Ejemplo:**
```
Ingrese: FIBO(8)
Resultado: 0, 1, 1, 2, 3, 5, 8, 13
```
