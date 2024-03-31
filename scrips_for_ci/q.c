#include <stdio.h>

int input_array(int array[], int len)
{
    int res = 0;

    if (len <= 0)
        res = 1;
    
    for (int i = 0; i < len; i++)
        if(scanf("%d", &array[i]) != 1)
            res = 1;

    return res;
}

int find_negs_average(int array[], int len, double *average_of_negs)
{
    if (array == NULL)
        return 1;
    
    int sum_negativ = 0;
    int count_negativ = 0;

    for (int i = 0; i < len; i++)
    {
        if (array[i] < 0)
        {
            sum_negativ += array[i];
            count_negativ++;
        }
    }

    if (count_negativ != 0)
        *average_of_negs = (double) sum_negativ / count_negativ;
    else
        return 2;

    return 0;
}

int main(void)
{
    int array[1000];
    int len;
    double average_of_negs;
    int rm;

    printf("Введите длину массива\n");

    if(scanf("%d", &len) != 1 || len <= 0)
    {
        printf("Ошибка ввода длины массива\n");
        return 1;
    }

    printf("Введите элементы массива\n");

    if(input_array(array, len))
    {
        printf("Ошибка ввода элементов\n");
        return 2;
    }

    rm = find_negs_average(array, len, &average_of_negs);
    if (rm == 0)
        printf("Среднее арефметическое отрицательных чисел равно: %lf\n", average_of_negs);
    else
        if (rm == 2)
        {
            printf("Нет отрицательных элементов в массиве\n");
            return 3;
        }
             
    return 0;
}
