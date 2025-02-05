// Implements a dictionary's functionality

#include <ctype.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <strings.h>

#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
} node;

// Choose number of buckets in hash table, using 52 becuase it's faster than 26 but more optimal than N = 1000s for small txts
const unsigned int N = 52;

// Hash table
node *table[N];

// Hash value
int unsigned hash_value;

// Word count
int unsigned word_count;

// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    // Convert to hash
    hash_value = hash(word);

    // Point to first node
    node *cursor = table[hash_value];

    //  Go through list
    while (cursor != 0)
    {
        if (strcasecmp(word, cursor->word) == 0)
        {
            return true;
        }
        cursor = cursor->next;
    }
    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    // Simple hash function from http://www.cse.yorku.ca/~oz/hash.html
    unsigned long hash = 5381;
    int c;
    while ((c = toupper(*word++)))
    {
        hash = ((hash << 5) + hash) + c;
    }
    return hash % N;
}

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    // Open the dictionary file
    FILE *source = fopen(dictionary, "r");

    // Handel error
    if (source == NULL)
    {
        printf("Unable to load %s\n",dictionary);
        return false;
    }

    // set word variable for load
    char word[LENGTH + 1];

    // Read each word in the file  - fscanf(file, "%s", word)  - will return EOF at ends of file
    while (fscanf(source, "%s", word) != EOF)
    {
        // Create a new node for each word  - node *n = malloc(sizeof(node));
        node *n = malloc(sizeof(node));

        // Hash word to obtain a has value
        if (n == NULL)
        {
            return false;
        }

        // Insert word into hash table at that location
        // strcpy(n->word, "Hello");   copies Hello into n
        strcpy(n->word, word);
        hash_value = hash(word);
        n->next = table[hash_value];
        table[hash_value] = n;
        word_count++;
    }

    // Close the dictionary file
    fclose(source);
    return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    if (word_count > 0)
    {
        return word_count;
    }
    return 0;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    // Go through buckets
    for (int i = 0; i < N; i++)
    {
        // Set cursor
        node *cursor = table[i];

        // Check not null and move + clear tmp
        while (cursor != NULL)
        {
            // Set tmp to cursor
            node *tmp = cursor;

            // Move cursor to next
            cursor = cursor->next;

            // clear tmp
            free(tmp);
        }

        // Return true at end of list
        if (i == N - 1 && cursor == NULL)
        {
            return true;
        }
    }
    return false;
}
