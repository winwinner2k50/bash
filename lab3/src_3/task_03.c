#include <stdio.h>

int div(int a, int b);

int main(void)
{
    int a = 5, b = 2;

    printf("%d div %d = %d\n", a, b, div(a, b));

    a = 10;
    b = 1;

    printf("%d div %d = %d\n", a, b, div(a, b));

    return 0;
}

int div(int a, int b)
{
    return a / b;
}
