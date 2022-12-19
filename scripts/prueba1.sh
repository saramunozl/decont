for url in data/urls.txt
do
    bash scripts/download.sh $url data
done


# Download the contaminants fasta file, uncompress it, and
# filter to remove all small nuclear RNAs

for url in data/contaminants.urls.txt
do
    bash scripts/download.sh $url res yes
done


# Index the contaminants file

bash scripts/index.sh res/contaminants.fasta res/contaminants_idx
