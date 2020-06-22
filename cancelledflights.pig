
-- load flights data
flightsdata = LOAD 'flights.csv' USING PigStorage(',') AS (year:int, month:int, airline:chararray, flight_number:int, dest_airport:chararray, distance:int, arrival_time:int, arriaval_delay:int, diverted:int, cancelled:int);
describe flightsdata;

--Extract year, month and cancelled fields
flights = FOREACH flightsdata GENERATE $0, $1, $9;
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
