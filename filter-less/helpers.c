#include "helpers.h"
#include <math.h>

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    // Loop over all pixels
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            // Take average of red, green, and blue
            int ave =
                round((image[i][j].rgbtRed + image[i][j].rgbtGreen + image[i][j].rgbtBlue) / 3.0);
            // Update pixel values
            image[i][j].rgbtRed = ave;
            image[i][j].rgbtGreen = ave;
            image[i][j].rgbtBlue = ave;
        }
    }
    return;
}

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    // Loop over all pixels
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            // Compute sepia values
            int sepiaRed = round(.393 * image[i][j].rgbtRed + .769 * image[i][j].rgbtGreen +
                                 .189 * image[i][j].rgbtBlue);
            int sepiaGreen = round(.349 * image[i][j].rgbtRed + .686 * image[i][j].rgbtGreen +
                                   .168 * image[i][j].rgbtBlue);
            int sepiaBlue = round(.272 * image[i][j].rgbtRed + .534 * image[i][j].rgbtGreen +
                                  .131 * image[i][j].rgbtBlue);
            // Update pixel with sepia values
            // Ensure the resulting value is no larger than 255
            // Red
            if (sepiaRed > 255)
            {
                sepiaRed = 255;
                image[i][j].rgbtRed = sepiaRed;
            }
            else
            {
                image[i][j].rgbtRed = sepiaRed;
            }
            // Green
            if (sepiaGreen > 255)
            {
                sepiaGreen = 255;
                image[i][j].rgbtGreen = sepiaGreen;
            }
            else
            {
                image[i][j].rgbtGreen = sepiaGreen;
            }
            // Blue
            if (sepiaBlue > 255)
            {
                sepiaBlue = 255;
                image[i][j].rgbtBlue = sepiaBlue;
            }
            else
            {
                image[i][j].rgbtBlue = sepiaBlue;
            }
        }
    }
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    // Create temp copy
    RGBTRIPLE copy[height][width];
    // loop through row
    for (int i = 0; i < height; i++)
    {
        // loop through pixels and copy
        for (int j = 0; j < width; j++)
        {
            copy[i][j] = image[i][j];
        }
        // loop through pixels and reflect
        for (int j = 0; j < width; j++)
        {
            image[i][j] = copy[i][width - j - 1];
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    // Create a copy of image
    RGBTRIPLE copy[height][width];
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            copy[i][j] = image[i][j];
        }
    }
    // Blur pixels
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int red = 0;
            int green = 0;
            int blue = 0;
            double counter = 0;
            for (int s = i - 1; s < i + 2; s++)
            {
                // check for top and bottom edge //
                if (s < 0 || s >= height)
                    continue;
                for (int m = j - 1; m < j + 2; m++)
                {
                    // check for left and right edge //
                    if (m < 0 || m >= width)
                        continue;
                    red += copy[s][m].rgbtRed;
                    green += copy[s][m].rgbtGreen;
                    blue += copy[s][m].rgbtBlue;
                    counter += 1;
                }
            }
            image[i][j].rgbtRed = round(red / counter);
            image[i][j].rgbtGreen = round(green / counter);
            image[i][j].rgbtBlue = round(blue / counter);
        }
    }
    return;
}
