#include <cs50.h>
#include <stdio.h>
#include <string.h>

const int BITS_IN_BYTE = 8;

void print_bulb(int bit);

int main(void)
{
    string message = get_string("Message: ");
    // loop through each char in message. Convert each char to binary and print out
    for (int i = 0; i < strlen(message); i++)
    {
        // convert char to ascii int
        int ascii_number = message[i];
        // set up array to put binary in
        int binary[] = {0, 0, 0, 0, 0, 0, 0, 0};
        // initialise j
        int j = 0;
        // convert ascii to binary and put in array
        while (ascii_number > 0)
        {
            binary[j] = ascii_number % 2;
            ascii_number = ascii_number / 2;
            j++;
        }
        // switch array around and print out array
        for (int k = BITS_IN_BYTE - 1; k >= 0; k--)
        {
            print_bulb(binary[k]);
        }
        printf("\n");
    }
}

void print_bulb(int bit)
{
    if (bit == 0)
    {
        // Dark emoji
        printf("\U000026AB");
    }
    else if (bit == 1)
    {
        // Light emoji
        printf("\U0001F7E1");
    }
}