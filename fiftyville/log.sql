-- Keep a log of any SQL queries you execute as you solve the mystery.


--the theft took place on July 28, 2023 and that it took place on Humphrey Street.


SELECT * FROM crime_scene_reports WHERE street = 'Humphrey Street' AND day = '28' AND month = 7 AND description LIKE '%CS50%';
--+-----+------+-------+-----+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
--| id  | year | month | day |     street      |                                                                                                       description                                                                                                        |
--+-----+------+-------+-----+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
--| 295 | 2023 | 7     | 28  | Humphrey Street | Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery. |
--+-----+------+-------+-----+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

SELECT * FROM interviews WHERE transcript LIKE '%bakery%' AND day = '28';
--+-----+---------+------+-------+-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
--| id  |  name   | year | month | day |                                                                                                                                                     transcript                                                                                                                                                      |
--+-----+---------+------+-------+-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
--| 161 | Ruth    | 2023 | 7     | 28  | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.                                                          |
--| 162 | Eugene  | 2023 | 7     | 28  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |
--| 163 | Raymond | 2023 | 7     | 28  | As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket. |
--+-----+---------+------+-------+-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

SELECT * FROM bakery_security_logs JOIN people ON bakery_security_logs.license_plate = people.license_plate WHERE day = '28' AND month = '7' AND hour = '10' AND minute < '26';

--+-----+------+-------+-----+------+--------+----------+---------------+--------+---------+----------------+-----------------+---------------+
--| id  | year | month | day | hour | minute | activity | license_plate |   id   |  name   |  phone_number  | passport_number | license_plate |
--+-----+------+-------+-----+------+--------+----------+---------------+--------+---------+----------------+-----------------+---------------+
--| 258 | 2023 | 7     | 28  | 10   | 8      | entrance | R3G7486       | 325548 | Brandon | (771) 555-6667 | 7874488539      | R3G7486       |
--| 259 | 2023 | 7     | 28  | 10   | 14     | entrance | 13FNH73       | 745650 | Sophia  | (027) 555-1068 | 3642612721      | 13FNH73       |
--| 260 | 2023 | 7     | 28  | 10   | 16     | exit     | 5P2BI95       | 221103 | Vanessa | (725) 555-4692 | 2963008352      | 5P2BI95       |
--| 261 | 2023 | 7     | 28  | 10   | 18     | exit     | 94KL13X       | 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       |
--| 262 | 2023 | 7     | 28  | 10   | 18     | exit     | 6P58WS2       | 243696 | Barry   | (301) 555-4174 | 7526138472      | 6P58WS2       |
--| 263 | 2023 | 7     | 28  | 10   | 19     | exit     | 4328GD8       | 467400 | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       |
--| 264 | 2023 | 7     | 28  | 10   | 20     | exit     | G412CB7       | 398010 | Sofia   | (130) 555-0289 | 1695452385      | G412CB7       |
--| 265 | 2023 | 7     | 28  | 10   | 21     | exit     | L93JTIZ       | 396669 | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       |
--| 266 | 2023 | 7     | 28  | 10   | 23     | exit     | 322W7JE       | 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       |
--| 267 | 2023 | 7     | 28  | 10   | 23     | exit     | 0NTHK55       | 560886 | Kelsey  | (499) 555-9472 | 8294398571      | 0NTHK55       |
--+-----+------+-------+-----+------+--------+----------+---------------+--------+---------+----------------+-----------------+---------------+



SELECT * FROM atm_transactions
JOIN bank_accounts ON atm_transactions.account_number = bank_accounts.account_number
JOIN people ON bank_accounts.person_id = people.id
JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
WHERE atm_location = "Leggett Street" AND atm_transactions.day = '28' AND atm_transactions.month = '7' AND atm_transactions.year = "2023" AND bakery_security_logs.hour = 10 AND bakery_security_logs.minute < 26;
--+-----+----------------+------+-------+-----+----------------+------------------+--------+----------------+-----------+---------------+--------+-------+----------------+-----------------+---------------+-----+------+-------+-----+------+--------+----------+---------------+
--| id  | account_number | year | month | day |  atm_location  | transaction_type | amount | account_number | person_id | creation_year |   id   | name  |  phone_number  | passport_number | license_plate | id  | year | month | day | hour | minute | activity | license_plate |
--+-----+----------------+------+-------+-----+----------------+------------------+--------+----------------+-----------+---------------+--------+-------+----------------+-----------------+---------------+-----+------+-------+-----+------+--------+----------+---------------+
--| 267 | 49610011       | 2023 | 7     | 28  | Leggett Street | withdraw         | 50     | 49610011       | 686048    | 2010          | 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       | 261 | 2023 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
--| 336 | 26013199       | 2023 | 7     | 28  | Leggett Street | withdraw         | 35     | 26013199       | 514354    | 2012          | 514354 | Diana | (770) 555-1861 | 3592750733      | 322W7JE       | 266 | 2023 | 7     | 28  | 10   | 23     | exit     | 322W7JE       |
--| 288 | 25506511       | 2023 | 7     | 28  | Leggett Street | withdraw         | 20     | 25506511       | 396669    | 2014          | 396669 | Iman  | (829) 555-5269 | 7049073643      | L93JTIZ       | 265 | 2023 | 7     | 28  | 10   | 21     | exit     | L93JTIZ       |
--| 246 | 28500762       | 2023 | 7     | 28  | Leggett Street | withdraw         | 48     | 28500762       | 467400    | 2014          | 467400 | Luca  | (389) 555-5198 | 8496433585      | 4328GD8       | 263 | 2023 | 7     | 28  | 10   | 19     | exit     | 4328GD8       |
--+-----+----------------+------+-------+-----+----------------+------------------+--------+----------------+-----------+---------------+--------+-------+----------------+-----------------+---------------+-----+------+-------+-----+------+--------+----------+---------------+

SELECT * FROM phone_calls
JOIN people ON phone_calls.caller = people.phone_number
JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
JOIN bank_accounts ON bank_accounts.person_id = people.id
JOIN atm_transactions ON atm_transactions.account_number = bank_accounts.account_number
WHERE phone_calls.year = "2023"
    AND phone_calls.month = "7"
    AND phone_calls.day = "28"
    AND phone_calls.duration <60
    AND bakery_security_logs.hour = 10 AND bakery_security_logs.minute < 26
    AND atm_transactions.atm_location = "Leggett Street" AND atm_transactions.day = '28' AND atm_transactions.month = '7' AND atm_transactions.year = "2023";

--+-----+----------------+----------------+------+-------+-----+----------+--------+-------+----------------+-----------------+---------------+-----+------+-------+-----+------+--------+----------+---------------+----------------+-----------+---------------+-----+----------------+------+-------+-----+----------------+------------------+--------+
--| id  |     caller     |    receiver    | year | month | day | duration |   id   | name  |  phone_number  | passport_number | license_plate | id  | year | month | day | hour | minute | activity | license_plate | account_number | person_id | creation_year | id  | account_number | year | month | day |  atm_location  | transaction_type | amount |
--+-----+----------------+----------------+------+-------+-----+----------+--------+-------+----------------+-----------------+---------------+-----+------+-------+-----+------+--------+----------+---------------+----------------+-----------+---------------+-----+----------------+------+-------+-----+----------------+------------------+--------+
--| 233 | (367) 555-5533 | (375) 555-8161 | 2023 | 7     | 28  | 45       | 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       | 261 | 2023 | 7     | 28  | 10   | 18     | exit     | 94KL13X       | 49610011       | 686048    | 2010          | 267 | 49610011       | 2023 | 7     | 28  | Leggett Street | withdraw         | 50     |
--| 255 | (770) 555-1861 | (725) 555-3243 | 2023 | 7     | 28  | 49       | 514354 | Diana | (770) 555-1861 | 3592750733      | 322W7JE       | 266 | 2023 | 7     | 28  | 10   | 23     | exit     | 322W7JE       | 26013199       | 514354    | 2012          | 336 | 26013199       | 2023 | 7     | 28  | Leggett Street | withdraw         | 35     |
--+-----+----------------+----------------+------+-------+-----+----------+--------+-------+----------------+-----------------+---------------+-----+------+-------+-----+------+--------+----------+---------------+----------------+-----------+---------------+-----+----------------+------+-------+-----+----------------+------------------+--------+

SELECT name FROM people WHERE phone_number = '(375) 555-8161';
--+-------+
--| name  |
--+-------+
--| Robin |
--+-------+
SELECT name FROM people WHERE phone_number = '(725) 555-3243';
--+--------+
--|  name  |
--+--------+
--| Philip |
--+--------+


SELECT * FROM airports WHERE city = "Fiftyville";
--+----+--------------+-----------------------------+------------+
--| id | abbreviation |          full_name          |    city    |
--+----+--------------+-----------------------------+------------+
--| 8  | CSF          | Fiftyville Regional Airport | Fiftyville |
--+----+--------------+-----------------------------+------------+

SELECT * FROM passengers
JOIN flights ON passengers.flight_id = flights.id
JOIN people ON passengers.passport_number = people.passport_number
WHERE flights.origin_airport_id = 8
    AND flights.year = 2023 AND flights.month = 7 AND flights.day = 29
    AND people.name = 'Diana';

--+-----------+-----------------+------+----+-------------------+------------------------+------+-------+-----+------+--------+--------+-------+----------------+-----------------+---------------+
--| flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |   id   | name  |  phone_number  | passport_number | license_plate |
--+-----------+-----------------+------+----+-------------------+------------------------+------+-------+-----+------+--------+--------+-------+----------------+-----------------+---------------+
--| 18        | 3592750733      | 4C   | 18 | 8                 | 6                      | 2023 | 7     | 29  | 16   | 0      | 514354 | Diana | (770) 555-1861 | 3592750733      | 322W7JE       |
--+-----------+-----------------+------+----+-------------------+------------------------+------+-------+-----+------+--------+--------+-------+----------------+-----------------+---------------+

SELECT * FROM passengers
JOIN flights ON passengers.flight_id = flights.id
JOIN people ON passengers.passport_number = people.passport_number
WHERE flights.origin_airport_id = 8
    AND flights.year = 2023 AND flights.month = 7 AND flights.day = 29
    AND people.name = 'Bruce';
--+-----------+-----------------+------+----+-------------------+------------------------+------+-------+-----+------+--------+--------+-------+----------------+-----------------+---------------+
--|- flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |   id   | name  |  phone_number  | passport_number | license_plate |
--+-----------+-----------------+------+----+-------------------+------------------------+------+-------+-----+------+--------+--------+-------+----------------+-----------------+---------------+
--| 36        | 5773159633      | 4A   | 36 | 8                 | 4                      | 2023 | 7     | 29  | 8    | 20     | 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       |
--+-----------+-----------------+------+----+-------------------+------------------------+------+-------+-----+------+--------+--------+-------+----------------+-----------------+---------------+



--destination_airport_id 4 or 6
SELECT full_name FROM airports WHERE id = 4;
--+-------------------+
--|     full_name     |
--+-------------------+
--| LaGuardia Airport |
--+-------------------+
SELECT full_name FROM airports WHERE id = 6;
--+-----------------------------+
--|          full_name          |
--+-----------------------------+
--| Logan International Airport |
--+-----------------------------+

SELECT city FROM airports WHERE id =4;
--+---------------+
--|     city      |
--+---------------+
--| New York City |
--+---------------+

/*

CREATE TABLE crime_scene_reports (
    id INTEGER,
    ear INTEGER,
    month INTEGER,
    day INTEGER,
    street TEXT,
    description TEXT,
    PRIMARY KEY(id)
);
--CREATE TABLE interviews (
    id INTEGER,
    name TEXT,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    transcript TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE atm_transactions (
    id INTEGER,
    account_number INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    atm_location TEXT,
    transaction_type TEXT,
    amount INTEGER,
    PRIMARY KEY(id)
);
CREATE TABLE bank_accounts (
    account_number INTEGER,
    person_id INTEGER,
    creation_year INTEGER,
    FOREIGN KEY(person_id) REFERENCES people(id)
);
CREATE TABLE airports (
    id INTEGER,
    abbreviation TEXT,
    full_name TEXT,
    city TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE flights (
    id INTEGER,
    origin_airport_id INTEGER,
    destination_airport_id INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    minute INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY(origin_airport_id) REFERENCES airports(id),
    FOREIGN KEY(destination_airport_id) REFERENCES airports(id)
);
CREATE TABLE passengers (
    flight_id INTEGER,
    passport_number INTEGER,
    seat TEXT,
    FOREIGN KEY(flight_id) REFERENCES flights(id)
);
CREATE TABLE phone_calls (
    id INTEGER,
    caller TEXT,
    receiver TEXT,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    duration INTEGER,
    PRIMARY KEY(id)
);
CREATE TABLE people (
    id INTEGER,
    name TEXT,
    phone_number TEXT,
    passport_number INTEGER,
    license_plate TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE bakery_security_logs (
    id INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    minute INTEGER,
    activity TEXT,
    license_plate TEXT,
    PRIMARY KEY(id)
);


*/
