#Download all the files specified in data/filenames

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
