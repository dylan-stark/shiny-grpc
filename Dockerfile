FROM rocker/rstudio

# Build in the open source Shiny server
RUN export ADD=shiny && bash /etc/cont-init.d/add

RUN apt-get update && apt-get install -y \
    autoconf \
    build-essential \
    clang \
    curl \
    libcurl4-gnutls-dev \
    libc++-dev \
    libgflags-dev \
    libssh2-1-dev \
    libssl-dev \
    libgtest-dev \
    libtool \
    libxml2-dev \
    pkg-config \
    xml2 \
    zlib1g-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/

# Install grpc library
RUN git clone -b $(curl -L https://grpc.io/release) https://github.com/grpc/grpc && \
    cd grpc && \
    git submodule update --init && \
    make && \
    make install && \
    cd third_party/protobuf && \
    make && \
    make install && \
    ldconfig

# Install grpc R package
RUN \
    R -e "install.packages('devtools', dep = TRUE)" && \
    R -e "install.packages('Rcpp')" && \
    R -e "install.packages('RProtoBuf')" && \
    R -e "devtools::install_github('nfultz/grpc')"

