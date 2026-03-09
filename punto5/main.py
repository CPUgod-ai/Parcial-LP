
import sys
from antlr4 import *
from FiboLexer import FiboLexer
from FiboParser import FiboParser

def fibonacci(n):
    resultado = [0, 1]
    for i in range(2, n):
        resultado.append(resultado[i-1] + resultado[i-2])
    return resultado[:n]

entrada = input("Ingrese: ")

stream = InputStream(entrada)
lexer = FiboLexer(stream)
parser = FiboParser(CommonTokenStream(lexer))
tree = parser.programa()

n = int(tree.NUMERO().getText())
print(", ".join(str(x) for x in fibonacci(n)))

