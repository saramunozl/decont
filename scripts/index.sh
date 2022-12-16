# This script should index the genome file specified in the first argument ($1),
# creating the index in a directory specified by the second argument ($2).

# The STAR command is provided for you. You should replace the parts surrounded
# by "<>" and uncomment it.

#-----------------------------------------------------------------------------------------------------------

# $1 = sample id --> contaminants.fasta.gz
# $2 = output directory --> res/contaminants_idx


	echo "Running STAR index..."

		
	mkdir -p res/$2
	
	STAR \
	--runThreadN 8 \
	--runMode genomeGenerate \
	--genomeDir $2 \
 	--genomeFastaFiles out/merged/$1 \
 	--genomeSAindexNbases 9
 	
 	echo
