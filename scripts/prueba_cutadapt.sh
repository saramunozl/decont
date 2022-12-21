# TODO: run cutadapt for all merged files
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

