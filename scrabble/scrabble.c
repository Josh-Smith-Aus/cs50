#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

// Points assigned to each letter of the alphabet
int POINTS[] = {1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10};

int compute_score(string word);

int main(void)
{
    // Get input words from both players
    string word1 = get_string("Player 1: ");
    string word2 = get_string("Player 2: ");

    // Score both words
    int score1 = compute_score(word1);
    int score2 = compute_score(word2);

    // Print the winner
    if (score1 > score2)
    {
        printf("Player 1 wins!\n");
    }
    if (score2 > score1)
    {
        printf("Player 2 wins!\n");
    }
    if (score1 == score2)
    {
        printf("Tie!\n");
    }
    else
    {
        return 0;
    }
}

int compute_score(string word)
{
    // for each letter in the string check its value agianst the points array
    // so A-Z = 65-132 or a-z 97-122
    int score = 0;
    for (int i = 0; i < strlen(word); i++)
    {
        int w = toupper(word[i]);
        if (w >= 65 && w <= 132)
        {
            score = score + POINTS[w - 65];
        }
    }

    return score;
}
