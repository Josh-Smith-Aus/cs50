// Get Key
// Validate Key
// Get plain text
// Encipher
// Print ciphertext

#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

bool hasUniqueLetters(const char *str);
#define NUM_LETTERS 26

int main(int argc, string argv[])
    {
        // Check that theres only two arguments
        if (argc != 2)
        {
            printf("Usage: ./substitution KEY\n");
            return 1;
        }
        string key = argv[1];
        // Check key only has letters
        for (int i = 0; i < strlen(key); i++)
        {
            if (!isalpha(key[i]))
            {
                printf("Key must contain only letters\n");
                return 1;
            }
        }
        // check key length: strlen(key) < 26
        if (strlen(key) != 26)
        {
            printf("Key must contain 26 letters\n");
            return 1;
        }
        // Check for repeated characters(case insensitive)
        for (int i = 0; i < strlen(key); i++)
        {
            for (int j = i + 1; j < strlen(key); j++)
            {
                if (toupper(key[i]) == toupper(key[j]))
                {
                    printf("Key must contain only one of each letter");
                    return 1;
                }
            }
        }
        // Prompt for plaintext
        string plaintext = get_string("plaintext: ");

        // Convert key to uppercase
        for (int i = 0; i <strlen(key); i++)
        {
            if (islower(key[i]))
            {
                key[i] = key[i] - 32;
            }
        }

        // Print cipher
        printf("ciphertext: ");
        for (int i = 0; i <strlen(plaintext); i++)
        {
            // If uppercase
            if (isupper(plaintext[i]) )
            {
                int letter = plaintext[i] - 65;
                printf("%c", key[letter]);
            }
            // If lowercase
            else if (islower(plaintext[i]) )
            {
                int letter = plaintext[i] - 97;
                printf("%c", key[letter] + 32);
            }
            // If not alphabetical
            else printf("%c", plaintext[i]);
        }
        printf("\n");
    }
