#Download all the files specified in data/filenames

for url in data/urls.txt
do
    bash scripts/download.sh $url data
done

#---------------------------------------------------------------------------------------------------

# Download the contaminants fasta file and uncompress it

for url in data/contaminants.urls.txt
do
    bash scripts/download.sh $url res yes
done

#---------------------------------------------------------------------------------------------------

# Index the contaminants file

bash scripts/index.sh res/contaminants.fasta res/contaminants_idx

#---------------------------------------------------------------------------------------------------

# Merge the samples into a single file

for sid in $(ls data/*.fastq.gz | cut -d"-" -f1 | sed "s:data/::" | sort | uniq)
do
    bash scripts/merge_fastqs.sh data out/merged $sid
done

#---------------------------------------------------------------------------------------------------

# Run cutadapt for all merged files

echo "----------------------------------------------------------------------------------------------"
echo "Removing the adapters from the data..."

mkdir -p out/trimmed
mkdir -p log/cutadapt

for sid in $(ls out/merged/*.fastq.gz | cut -d"." -f1 | sed "s:out/merged/::")

    do
        cutadapt \
        -m 18 \
        -a TGGAATTCTCGGGTGCCAAGG --discard-untrimmed \
        -o out/trimmed/$sid.trimmed.fastq.gz \
        out/merged/$sid.merged.fastq.gz > log/cutadapt/$sid.log
    
    done

echo "Done..."

#---------------------------------------------------------------------------------------------------

# Run STAR for all trimmed files

echo "----------------------------------------------------------------------------------------------"
echo "Running STAR alignment..."

for fname in out/trimmed/*.fastq.gz

    do
        sid=$(ls $fname | cut -d"." -f1 | sed "s:out/trimmed/::")
        mkdir -p out/star/${sid}
     
         STAR \
         --runThreadN 8 \
         --genomeDir res/contaminants_idx \
         --outReadsUnmapped Fastx \
         --readFilesIn $fname \
         --readFilesCommand gunzip -c \
         --outFileNamePrefix out/star/${sid}/
    done

echo "Done..."

#---------------------------------------------------------------------------------------------------

# Create a log file containing information from cutadapt and star logs
# - cutadapt: Reads with adapters and total basepairs
# - star: Percentages of uniquely mapped reads, reads mapped to multiple loci, and to too many loci

echo "----------------------------------------------------------------------------------------------"
echo "Creating a Log file with the results..."

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

#---------------------------------------------------------------------------------------------------

# Export a file with my conda environment information

echo "----------------------------------------------------------------------------------------------"
echo "Export conda environment information"

conda env export --from-history > conda.environment

echo "Done..."
