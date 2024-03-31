#include <stdio.h>

int input_array(int *pa, int *end_array)
{
    int res = 0;
    while (pa != end_array)
    {
        if(scanf("%d", pa) != 1) 
            res = 1;
        pa++;
    }
    return res;
}


int min_multiplication_array(int *pa, int *end_array)
{
    int min_res = (*pa) * (*(pa + 1));
    pa++;
    while (pa + 1 != end_array)
    {
        if ((*pa) * (*(pa + 1)) < min_res)
            min_res = (*pa) * (*(pa + 1));
        pa++;
    }
    return min_res;
}


int main(void)
{
    int array[1000];
    int len;
    printf("Введите длину массива\n");

    if(scanf("%d", &len) != 1 || len <= 0)
    {
        printf("Ошибка ввода длины массива\n");
        return 1;
    }

    printf("Введите элементы массива\n");

    if(input_array(array, array + len))
    {
        printf("Ошибка ввода элементов\n");
        return 2;
    }

    printf("%d\n", min_multiplication_array(array, array + len));

}