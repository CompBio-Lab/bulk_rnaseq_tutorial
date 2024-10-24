# bulk_rnaseq_tutorial

## download repo
```
git clone https://github.com/CompBio-Lab/bulk_rnaseq_tutorial.git
cd bulk_rnaseq_tutorial
```

## create docker image locally
```
make build
make push
```

## pull docker image on hpc
- set $ALLOC=st-allocation-1
- make user dir if not already

```
cd /scratch/$ALLOC/$USER/
module load git
git clone https://github.com/CompBio-Lab/bulk_rnaseq_tutorial.git
cd bulk_rnaseq
mkdir data results results/fastqc results/trim results/align results/counts
```

## download docker image 
```
cd data
module load gcc apptainer
DOCKERHUB_USERNAME=singha53
IMAGE_VERSION=v0.1
IMAGE_NAME=rnaseq
apptainer pull --name bulk_rnaseq.sif docker://$DOCKERHUB_USERNAME/$IMAGE_NAME:$IMAGE_VERSION
```

## download genome in data folder
```
mkdir data
cd
wget https://genome-idx.s3.amazonaws.com/hisat/grch38_genome.tar.gz 
tar -xvzf grch38_genome.tar.gz
rm grch38_genome.tar.gz
```

## download genome and gtf in data folder
```
wget https://ftp.ensembl.org/pub/release-112/gtf/homo_sapiens/Homo_sapiens.GRCh38.112.gtf.gz && \
gzip -d Homo_sapiens.GRCh38.112.gtf.gz
```

## run analysis

### run fastqc
```
cd analysis
sbatch run_fastqc.sh
```
- [how to interpret fastqc doc](https://hbctraining.github.io/Intro-to-rnaseq-hpc-salmon/lessons/qc_fastqc_assessment.html)

### run trimmomatic
- [trimmomatic docs](http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf)

```
mkdir results/trim
cd bulk_rnaseq/analysis/
sbatch run_trim.sh
```

### run fastqc on trimmed fastq files

```
cd bulk_rnaseq/analysis/
sbatch run_fastqc_trim.sh
```

### align trimmed reads

```
cd bulk_rnaseq/analysis/
sbatch run_align.sh
```

### count trimmed reads

```
cd bulk_rnaseq/analysis/
sbatch run_count.sh
```

### download results folder from remote to local
```
local_path="path to folder where you want to copy to"
remote_path="remote path of folder you want to copy"
cp -r cwl@dtn.sockeye.arc.ubc.ca:$remote_path $local_path
```
- cwl is you ubc cwl