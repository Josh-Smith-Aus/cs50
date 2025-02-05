#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    // Accept a single command-line argument
    if (argc != 2)
    {
        printf("Usage: ./recover FILE\n");
        return 1;
    }

    // Open the memory card
    FILE *card = fopen(argv[1], "r");
    // Check input is valid
    if (card == NULL)
    {
        printf("Could not open %s.\n", argv[1]);
        return 2;
    }

    // Set outfile pointer to NULL
    FILE *outptr = NULL;

    // Create an array of 512 elements to store 512 bytes from the memory card
    uint8_t buffer[512];

    // Count amount of jpeg files found
    int jpeg_num = 0;

    // String to hold a filename
    char filename[8] = {0};

    // While there's still data left to read from the memory card
    while (fread(buffer, 1, 512, card) == 512)
    {
        // Create JPEGs from the data

        // Check if JPEG id found
        if (buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff &&
            (buffer[3] & 0xf0) == 0xe0)
        {
            // Check if not first
            if (outptr != NULL)
            {
                fclose(outptr);
            }
            // save jpg using: sprintf(filename, "%03i.jpg", 2);
            sprintf(filename, "%03i.jpg", jpeg_num++);
            // outptr: FILE *img = fopen(filename, "w")
            // Open new outptr
            outptr = fopen(filename, "w");
        }

        //
        if (outptr != NULL)
        {
            // fwrite(data,size,number,outptr)
            fwrite(buffer, 512, 1, outptr);
        }
    }

    // close any remining files
    if (outptr != NULL)
    {
        fclose(outptr);
    }

    fclose(card);
}
