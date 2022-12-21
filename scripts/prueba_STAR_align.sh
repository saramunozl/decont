
# TODO: run STAR for all trimmed files

echo "Run STAR alignment..."
for fname in out/trimmed/*.fastq.gz
do
    # you will need to obtain the sample ID from the filename
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
echo 
