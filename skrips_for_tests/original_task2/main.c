#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define PI 2.0 * asin(1.0)

int main(void)
{
    // объявление переменн
    double a b;
    double alf;
    double s;

    // приглашение к вводу
    printf("Введите стороны треугольника (a,b)\n");
    printf("и угол между ними:\n");

    // ввод данных
    int rm1 = scanf("%lf%lf", &a, &b);
    int rm2 = scanf("%lf", &alf);
    // проверка ввода
    if (rm1 == 2 && rm2 == 1)
    {
        //вычисления
        alf *= PI / 180.0;
        s = a * b * sin(alf) * 0.5;
        //вывод
        printf("Площадь треугольника: %.6lf\n", s);
    }
    else
    {
        printf("Неверный ввод");
        return 1;
    }
    return 0;
}
