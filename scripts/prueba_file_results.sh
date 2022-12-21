echo "----------------------------------------------------------------------------------------------"
echo "Creating a Log file with the results----------------------------------------------------------"

echo "=== TOTAL RESULTS ===" >> Log.out
echo "" >> Log.out

for fname in log/cutadapt/*.log
	
	do
		sid=$(basename $fname | cut -d"." -f1)
		echo "${sid} cutadapt results.................................." >> Log.out
		echo "" >> Log.out
		
		cat $fname | egrep "Reads with adapters|Total basepairs" >> Log.out
		echo "" >> Log.out 
			
		echo "${sid} STAR results......................................" >> Log.out
		echo "" >> Log.out
        	cat out/star/${sid}/Log.final.out | egrep "reads %|% of reads mapped to (multiple|too)" >> Log.out
        	echo "" >> Log.out
        done
    
echo "Done..."
