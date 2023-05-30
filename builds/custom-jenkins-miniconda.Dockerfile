FROM jenkins/jenkins:lts
# BUILD FROM https://github.com/mostly-ai/jenkins-miniconda/blob/master/Dockerfile
USER root 
RUN apt-get -yqq update && apt-get -yqq install docker.io
RUN apt-get -yqq install python3
RUN apt-get -yqq install python3-dev
RUN apt-get -yqq install python3-pip

RUN apt-get -yqq install wget

# Install Miniconda
RUN mkdir /tmp/miniconda
WORKDIR /tmp/miniconda
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN chmod +x Miniconda3-latest-Linux-x86_64.sh
RUN ./Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda

# Add mostlyai and conda-forge as systemwide channels
RUN /opt/conda/bin/conda config --add channels conda-forge --system
RUN /opt/conda/bin/conda config --add channels mostlyai --system

# Change non-interactive shell to bash - Miniconda activate fails for
# R packages in dash as it doesn't support functions in shell scripts
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# Clean up
WORKDIR /
RUN rm -rf /tmp/miniconda

RUN usermod -g docker jenkins
USER jenkins 