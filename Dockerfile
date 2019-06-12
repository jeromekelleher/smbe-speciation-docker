FROM jupyter/scipy-notebook

USER root

RUN rm -rf /var/lib/apt/lists/* && apt-get clean
RUN  apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential cmake libgiac-dev

# Install SLiM
RUN wget http://benhaller.com/slim/SLiM.zip 
RUN unzip SLiM.zip
RUN mkdir SLiM/build 
RUN cd SLiM/build && cmake .. && make install -j 4
RUN rm -fR SLiM*

RUN conda install --quiet --yes \
    msprime zarr scikit-allel \
    more-itertools tqdm sympy networkx psutil pandas \
    docopt pytables tabulate htop \
    && conda clean -tipsy 
 
RUN conda install --quiet --yes \
    -c bioconda pysam \
    && conda clean -tipsy 

RUN pip install tsinfer pyslim
RUN pip install --pre --upgrade tskit

# nbgitpuller to pull in data files, images etc.
RUN pip install nbgitpuller
RUN jupyter serverextension enable --py nbgitpuller --sys-prefix

# Clone gIMble
RUN git clone https://github.com/DRL/gIMble.git

RUN fix-permissions /home/jovyan
USER $NB_UID
