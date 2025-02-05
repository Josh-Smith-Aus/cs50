#include <cs50.h>
#include <stdio.h>

int main(void)
{
    //Prompt for start size

    int start_size;
    do
    {
        start_size = get_int("Enter start size: ");
    }
    while (start_size < 9);


    //Prompt for end size

    int end_size;
    do
    {
        end_size = get_int("Enter end size: ");
    }
    while (end_size < start_size);

    //keep track of years
    int years_to_threshold = 0;

    //Calculate number of years until we reach threshold
    //let n = number of lamas
    // lamas born per year = n/3
    // lamas die per year = n/4
    //every year increase n by n/3 and reduce n by n/4
    while (start_size < end_size)
    {
        start_size = start_size + (start_size / 3) - (start_size / 4);
        years_to_threshold++;
    }

    // Print number of years

    printf("Years: %i \n", years_to_threshold);

}

