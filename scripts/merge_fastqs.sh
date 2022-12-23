# This script should merge all files from a given sample (the sample id is
# provided in the third argument ($3)) into a single file, which should be
# stored in the output directory specified by the second argument ($2).
#
# The directory containing the samples is indicated by the first argument ($1).

#---------------------------------------------------------------------------------------------------

# $1 = input directory --> data
# $2 = output directory --> out/merged
# $3 = sample id (sid) --> C57BL_6NJ or SPRET_EiJ

echo "----------------------------------------------------------------------------------------------"
echo "Merging the files from same samples..."
	
	sid=$3
	
	mkdir -p out/merged

	cat $1/${sid}-12.5dpp.1.1s_sRNA.fastq.gz $1/${sid}-12.5dpp.1.2s_sRNA.fastq.gz \
	> $2/${sid}.merged.fastq.gz

echo "Done..."


