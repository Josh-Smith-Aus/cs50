from cs50 import get_int

# Prompt the user for the half-pyramid’s height, a positive integer between 1 and 8
# If the user fails to provide a positive integer no greater than 8, you should re-prompt for the same again.

while True:
    height = get_int("Height: ")
    if height > 0 and height < 9:
        break


# Then, generate (with the help of print and one or more loops) the desired half-pyramid.

for i in range(0, height, 1):
    for j in (range(0, height, 1)):
        if (i+j < height-1):
            print(" ", end="")
        else:
            print("#", end="")
    print()
