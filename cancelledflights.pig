
-- load flights data
flightsdata = LOAD 'flights.csv' USING PigStorage(',') AS (year:int, month:int, airline:chararray, flight_number:int, dest_airport:chararray, distance:int, arrival_time:int, arriaval_delay:int, diverted:int, cancelled:int);
--describe flightsdata;

-- Ranked all the datas
ranked_flightsdata = RANK flightsdata;
--DESCRIBE ranked_flightsdata;

-- Remove header from data.
noheader = FILTER ranked_flightsdata BY (rank_flightsdata > 1);
--limit5 = limit noheader 5;
--Dump limit5;

--Extract year, month and cancelled fields
flights = FOREACH noheader GENERATE $1, $2, $10;
--DESCRIBE flights;

-- Get all cancelled flights.
cancelledflights = FILTER flights by cancelled == 1;

-- Group cancelled flights by year and month field.
cancelledflightsbymonth = GROUP cancelledflights by ($0, $1);
--describe cancelledflightsbymonth;
--DUMP cancelledflightsbymonth;

-- Count the cancelled flights.
countcancelledflights = FOREACH cancelledflightsbymonth GENERATE FLATTEN(group), COUNT(cancelledflights) as Count;
--describe countcancelledflights;
--DUMP countcancelledflights;

STORE countcancelledflights INTO 'CancelledFlights' USING PigStorage(',');
