FROM ubuntu:mantic-20230926

# install dependencies; cleanup apt garbage
RUN apt-get update -y && apt-get install -y \
  build-essential \
  bzip2 \
  cmake \ 
  make \
  default-jre \
  git \
  libnss-sss \
  libtbb-dev \
  ncurses-dev \
  perl \
  python3-dev \
  python3-venv \
  python3-pip \
  tzdata \
  unzip \
  wget \
  zlib1g \
  zlib1g-dev

# install fastqc
ARG FASTQC_VER="0.11.8"
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${FASTQC_VER}.zip && \
    unzip fastqc_v${FASTQC_VER}.zip && \
    rm fastqc_v${FASTQC_VER}.zip && \
    chmod +x FastQC/fastqc
ENV PATH="${PATH}:/FastQC/"

# install trimmomatic
ARG TRIMMOMATIC_VER="0.38"
RUN wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-${TRIMMOMATIC_VER}.zip && \
    unzip Trimmomatic-${TRIMMOMATIC_VER}.zip && \
    rm Trimmomatic-${TRIMMOMATIC_VER}.zip
ENV PATH="${PATH}:/Trimmomatic-${TRIMMOMATIC_VER}/"

# install HiSat2
ARG HISAT2_VER="2.1.0"
RUN wget ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-${HISAT2_VER}-Linux_x86_64.zip && \
    unzip hisat2-${HISAT2_VER}-Linux_x86_64.zip && \
    rm hisat2-${HISAT2_VER}-Linux_x86_64.zip
ENV PATH="${PATH}:/hisat2-${HISAT2_VER}/"

# HTSlib
ENV HTSLIB_INSTALL_DIR=/opt/htslib
WORKDIR /tmp
RUN wget https://github.com/samtools/htslib/releases/download/1.3.2/htslib-1.3.2.tar.bz2 && \
    tar --bzip2 -xvf htslib-1.3.2.tar.bz2 && \
    cd /tmp/htslib-1.3.2 && \
    ./configure  --enable-plugins --prefix=$HTSLIB_INSTALL_DIR && \
    make && \
    make install && \
    cp $HTSLIB_INSTALL_DIR/lib/libhts.so* /usr/lib/

# install Samtools
WORKDIR /tmp
ARG SAMTOOLS_VER="1.3.1"
RUN wget https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VER}/samtools-${SAMTOOLS_VER}.tar.bz2 && \
    tar --bzip2 -xf samtools-${SAMTOOLS_VER}.tar.bz2 && \
    cd /tmp/samtools-${SAMTOOLS_VER} && \
    ./configure --with-htslib=$HTSLIB_INSTALL_DIR --prefix=$SAMTOOLS_INSTALL_DIR && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/samtools-${SAMTOOLS_VER}
ENV PATH="${PATH}:/samtools-${SAMTOOLS_VER}/"

# install subread
ARG SUBREAD_VER="2.0.2"
WORKDIR /bin
# RUN apt-get update && apt-get install --yes make libz-dev procps pigz
RUN wget https://sourceforge.net/projects/subread/files/subread-${SUBREAD_VER}/subread-${SUBREAD_VER}-source.tar.gz
RUN tar zxvf subread-${SUBREAD_VER}-source.tar.gz
WORKDIR /bin/subread-${SUBREAD_VER}-source/src
RUN make -f Makefile.Linux
ENV PATH="${PATH}:/bin/subread-${SUBREAD_VER}/"
RUN cp -r ../bin/* /usr/bin

# set working directory
WORKDIR /home