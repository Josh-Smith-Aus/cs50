from cs50 import get_float


def main():
    # Ask how many cents the customer is owed
    cents = get_cents()

    # Calculate the number of quarters to give the customer
    quarters = calculate_quarters(cents)
    cents = cents - quarters * 25

    # Calculate the number of dimes to give the customer
    dimes = calculate_dimes(cents)
    cents = cents - dimes * 10

    # Calculate the number of nickels to give the customer
    nickels = calculate_nickels(cents)
    cents = cents - nickels * 5

    # Calculate the number of pennies to give the customer
    pennies = calculate_pennies(cents)
    cents = cents - pennies * 1

    # Sum coins
    coins = quarters + dimes + nickels + pennies

    # Print total number of coins to give the customer
    print(f"{coins}")


def get_cents():
    while True:
        n = get_float("Change: ")
        if n >= 0:
            return n*100
            break


def calculate_quarters(cents):
    n = int(cents / 25)
    return n


def calculate_dimes(cents):
    n = int(cents / 10)
    return n


def calculate_nickels(cents):
    n = int(cents / 5)
    return n


def calculate_pennies(cents):
    n = int(cents / 1)
    return n


main()
