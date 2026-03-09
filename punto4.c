#include <stdio.h>
#include <time.h>

int fibonacci(int n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int main() {
    int n = 35;
    clock_t inicio = clock();
    int resultado = fibonacci(n);
    clock_t fin = clock();

    double tiempo = (double)(fin - inicio) / CLOCKS_PER_SEC;
    printf("fibonacci(%d) = %d\n", n, resultado);
    printf("Tiempo C: %.6f segundos\n", tiempo);
    return 0;
}