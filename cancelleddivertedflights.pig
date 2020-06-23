-- Load flights data from file.
flightsdata = LOAD 'flights.csv' USING PigStorage(',') AS (year:int, month:int, airline:chararray, flight_number:int, dest_airport:chararray, distance:int, arrival_time:int, arriaval_delay:int, diverted:int, cancelled:int);
--DESCRIBE flightsdata;

-- Remove header.
ranked_flightsdata = RANK flightsdata;
describe ranked_flightsdata;
no_headers_flightsdata = FILTER ranked_flightsdata by (rank_flightsdata > 1);
--DESCRIBE no_headers_flightsdata

-- Take airline, diverted and cancelled fields.
flights = FOREACH no_headers_flightsdata GENERATE $3,$9,$10;
--DESCRIBE flights;

-- Takes flight which are cancelled and delayed;
flights_candely = FILTER flights BY (cancelled == 1) OR (diverted == 1);


-- count Deleyed and cancelled flight
groupbyflightairline = GROUP flights_candely BY airline;
--DESCRIBE groupbyflightairline

countflightairline = FOREACH groupbyflightairline GENERATE group as airline, COUNT(flights_candely.diverted) as diverted, COUNT(flights_candely.cancelled) as cancelled;
--DESCRIBE countflightairline

--DUMP countflightairline;

-- Load Airline data from file.
airlinesdata = LOAD 'airlines.csv' USING PigStorage(',') AS (airline:chararray, airline_name:chararray);
--DESCRIBE airlinesdata;

-- Remove header
ranked_airlinesdata = RANK airlinesdata;
no_headers_airlinesdata = FILTER ranked_airlinesdata by (rank_airlinesdata > 1);
--DESCRIBE no_headers_airlinesdata;

-- Take airline and airline_name
airlines = FOREACH no_headers_airlinesdata GENERATE $1,$2;


-- join flight and airline data

flightairline = JOIN countflightairline BY airline, airlines BY airline;
--DESCRIBE flightairline;


-- Retrive Name, Code, Dicerted count and Cancelled count
delayedandcancelledflights = FOREACH flightairline GENERATE $4, $0, $1, $2;

--DUMP delayedandcancelledflights;

STORE delayedandcancelledflights INTO 'AirlineDivertedCancelledCount' using PigStorage(',');
