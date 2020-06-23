# Airline-Data-Analysis-Using-Pig

DESCRIPTION

The US Department of Transport collects statistics from all the airlines, which include airline details, airport details, and flight journey details.
These airlines have a global presence and they operate almost in every country.
Flight data can help to decide which airline provides better service and find the routes in which flights are getting delayed.
The data collected is present in the files: flight.csv, airline.csv, and aiport.csv.
You are hired as a big data consultant to provide important insights.
Your task is to write MapReduce jobs and provide insights on:

1. The number of flights that get canceled in a month, every year [Code](./cancelledflights.pig)
2. The airline names and the number of times their flights were canceled and diverted [Code](./cancelleddivertedflights.pig)
3. The number of times flights were delayed for each airline [Code](./divertedflights.pig)