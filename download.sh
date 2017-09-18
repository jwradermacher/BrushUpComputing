#!/bin/bash

echo "This scripts downloads data from google finance"

# 1. create folder with the name "data"
# 	 this removes data folder if it exists and then creates it
rm -rf data && mkdir data
echo "line 8"

# 2. next, we define important parameters
#    we will first define range of years for which we wish to obtain data 
#    on stocks

# - create a variable called LOW for lower end of the range, assign some value 
#   bigger than 2000 
LOW=2008
echo "LOW = " $LOW

# - create a variable called HIGH for higher end of the range, 
#   assign some value bigger than 2000, 
#   should be also bigger than the previous variable 
HIGH=2009
echo "HIGH = " $HIGH

# 3. we create a list of stocks for which we donwload the data
#    we create a variable called LIST
#    we are using stock tickers as an identifier of each stock
#    see https://finance.yahoo.com/lookup
LIST='AAPL FB GOOG MSFT'
echo "LIST = " $LIST

# 4. we write a for loop that will iterate over LIST and download a csv file
#    for each stock in the list for a range of years that were passed into
#    the file as arguments when the script is being called 
for stock in $LIST
do
	echo "line 37"
	echo $stock

	# - in each iteration we download the CSV file using a URL,
	#   use wget command with the following URL: 
	#   "http://www.google.com/finance/historical?q=NASDAQ:GOOG&startdate=Jan+1,2008&enddate=Jan+1,2010&output=csv"
	# - ou will need to modify some parts of the URL, in the example above
	#   you would substitute "GOOG", "2008", and "2010". Instead of "GOOG" you 
	#   should insert an element from the LIST, and instead of "2008" 
	#   and "2010" you should call LOW and HIGH variable, defined in 2)
	wget "http://www.google.com/finance/historical?q=NASDAQ:$stock&startdate=Jan+1,$LOW&enddate=Jan+1,$HIGH&output=csv"

	# each downloaded csv file should look like this:
	# 
	# Date,Open,High,Low,Close,Volume
	# 14-Sep-17,158.99,159.40,158.09,158.28,23192480
	# 13-Sep-17,159.87,159.96,157.91,159.65,44907361
	# and so on
done

# - move all the downloaded csv files into the data folder
mv hist* data/

# 5. Compress the folder "data" using tar command and save it in the same folder with the name "data.tar.gz"
tar cvfz data.tar.gz data/ 

# 6. Remove the folder "data"
rm -r -i data 

