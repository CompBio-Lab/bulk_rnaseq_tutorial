
setup:
	mkdir results results/fastqc results/trim results/align results/counts

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
