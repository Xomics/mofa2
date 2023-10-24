# Dockerfile VERSION = v0.6
# docker login registry.cmbi.umcn.nl
# docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')  -t registry.cmbi.umcn.nl/x-omics-action-dataset/action_nextflow/mofa2:$VERSION . 
# docker push registry.cmbi.umcn.nl/x-omics-action-dataset/action_nextflow/mofa2:$VERSION
# sudo docker pull registry.cmbi.umcn.nl/x-omics-action-dataset/action_nextflow/mofa2$VERSION
# sudo docker images # to get IMAGE_ID
# sudo docker save $IMAGE_ID -o mofa2.tar
# sudo singularity build mofa2.sif docker-archive://mofa2.tar

FROM gtca/mofa2

ARG BUILD_DATE

LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vendor="Radboudumc, Medical Biosciences department"
LABEL maintainer="casper.devisser@radboudumc.nl"

# Installations needed for devtools package
RUN apt-get update --allow-releaseinfo-change
RUN apt install net-tools -y
RUN apt install build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev -y

# Installations needed for R Cairo package
RUN apt-get install libcairo2-dev -y
RUN apt-get install libxt-dev -y

# Installations needed for R lme4 package
RUN apt install cmake -y
#RUN apt install libudunits2-dev -y

# Installation of BiocManager and biocLite
RUN R -e "install.packages('BiocManager', version = '3.12')" \
        && R -e "BiocManager::install('biocLite')" 

# R installations needed for devtools and devtools itself
RUN R -e "install.packages('installr')" \
        && R -e "installr::install.Rtools(check = TRUE, check_r_update = FALSE, GUI = FALSE)" \
        && R -e "install.packages(c('systemfonts', 'textshaping', 'ragg', 'pkgdown', 'Cairo', 'lme4'))" \
        && R -e "install.packages(c('devtools', 'psych', 'gee'))"  \
        && R -e "install.packages('corrplot', version='0.92')"


# Installation of tidyverse package from GitHub (v1.3.1) 
RUN R -e "devtools::install_github('hadley/tidyverse')"

# Installation of ggbubr
RUN R -e "install.packages('ggbubr', dependencies = TRUE, repos = 'http://cran.rstudio.com/')"

# Installations for Nextflow metrics, 'ps' command
RUN apt-get update && apt-get install libglib2.0-dev -y
RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*

# Pandoc installation
RUN apt-get -y update && apt-get install -y \
    build-essential \
    cmake \
    pandoc