fastqc:
	bash fastqc.sh files.txt ../results/fastqc/

trim:
	bash trim.sh files.txt

fastqc_trim:
	sh fastqc_trim.sh /scratch/st-wang85-1/singha53/bulk_rnaseq/results/trim

align:
	bash align.sh files.txt

count:
	bash count.sh files.txt

qstat:
	qstat -u $(USER)