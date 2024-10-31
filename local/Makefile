SRA=SRR24640458

setup:
	mkdir data results results/fastqc results/trim results/align results/counts

configsra:
	vdb-config -i

prefetchsra:
	cd data \
	prefetch $(SRA)

extractsra:
	cd data \
	fasterq-dump $(SRA)

samplereads:
	seqtk sample -s100 data/SRR24640458_1.fastq 400000 > data/SRR24640458_1_sample.fastq
	seqtk sample -s100 data/SRR24640458_2.fastq 400000 > data/SRR24640458_2_sample.fastq

fastqc:
	bash code/fastqc.sh files.txt results/fastqc/

trim:
	bash code/trim.sh files.txt

fastqc_trim:
	sh code/fastqc_trim.sh results/trim

genome:
	cd data \
	wget https://genome-idx.s3.amazonaws.com/hisat/grch38_genome.tar.gz \
	tar -xvzf grch38_genome.tar.gz \
	rm grch38_genome.tar.gz

gtf:
  cd data \
	wget https://ftp.ensembl.org/pub/release-112/gtf/homo_sapiens/Homo_sapiens.GRCh38.112.gtf.gz && \
	gzip -d Homo_sapiens.GRCh38.112.gtf.gz

align:
	bash code/align.sh files.txt

count:
	bash code/count.sh files.txt
