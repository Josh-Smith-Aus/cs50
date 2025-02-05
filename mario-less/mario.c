#include <cs50.h>
#include <stdio.h>

int get_height(void);

int main(void)
{
    //get height from user
    int height = get_height();

    //create pyramid
    for (int i = 1; i <= height ; i ++)
    {
        //print spaces
        for (int j = height - i; j > 0 ; j--)
        {
            printf(" ");
        }
        //print hash
        for (int n = i; n > 0 ; n--)
        {
            printf("#");
        }
        //print 2 spaces
        printf("  ");

        //print left alligned pyramid
        for (int p = 1; p <= i; p++)
        {
            printf("#");
        }
        //print next line
        printf("\n");
    }
}

int get_height(void)
{
    int n;
    do
    {
        n = get_int("Height: ");
    }
    while (n > 8 || n < 1);
    return n;
}