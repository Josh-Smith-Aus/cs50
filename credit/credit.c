#include <cs50.h>
#include <stdio.h>


int main(void)
{

    //request cc number
    long long ccNum;
    do
    {
        ccNum = get_long_long("Enter Card number: ");
    }
    while (ccNum < 1);

    //Luhns algo check
    long long tempCC;
    int sum = 0, sum1 = 0, counter = 1, currentNum, total;
    tempCC = ccNum;

    for (; tempCC > 0; tempCC /= 10, counter++)
    {
        currentNum = tempCC % 10;
        if (counter % 2 == 0)
        {
            currentNum = currentNum * 2;
            if (currentNum > 9)
            {
                currentNum = currentNum - 9;
            }
            sum += currentNum;
        }
        else
        {
            sum1 += currentNum;
        }
    }

    //CC type check + print out result
    total = sum + sum1;
    if (total % 10 == 0)
    {
        tempCC = ccNum;
        while (tempCC < 10 || tempCC > 100)
        {
            tempCC /= 10;
        }

        if (((counter - 1) == 15) && (tempCC == 34 || tempCC == 37))
        {
            printf("AMEX\n");
        }
        else if (((counter - 1) == 16) && (tempCC >= 51 && tempCC <= 55))
        {
            printf("MASTERCARD\n");
        }
        else if ((((counter - 1) == 13) || ((counter - 1) == 16)) && (tempCC / 10 == 4))
        {
            printf("VISA\n");
        }
        else
        {
            printf("INVALID\n");
        }
    }
    else
    {
        printf("INVALID\n");
    }
}