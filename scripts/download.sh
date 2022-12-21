# This script should download the file specified in the first argument ($1),
# place it in the directory specified in the second argument ($2),
# and *optionally*:
# - uncompress the downloaded file with gunzip if the third
#   argument ($3) contains the word "yes"
# - filter the sequences based on a word contained in their header lines:
#   sequences containing the specified word in their header should be **excluded**
#
# Example of the desired filtering:
#
#   > this is my sequence
#   CACTATGGGAGGACATTATAC
#   > this is my second sequence
#   CACTATGGGAGGGAGAGGAGA
#   > this is another sequence
#   CCAGGATTTACAGACTTTAAA
#
#   If $4 == "another" only the **first two sequence** should be output

#--------------------------------------------------------------------------------------------------

# $1 = text file with urls (data/urls.txt or data/url
# $2 = output directory --> data or res
# $3 = "yes" or "no"

echo "----------------------------------------------------------------------------------------------"		
echo "Downloading the sequencing data files..."
    
	wget -i $1 -P $2

echo "Done..."


echo "Uncompressing the downloaded file..."
    
	if [ $3 == "yes" ]
	then
		gunzip -k $2/*fasta.gz
	fi

echo "Done..."


echo "Filtering the file..."

	if [ $4 ==  ]

echo "Done..."
	
	
