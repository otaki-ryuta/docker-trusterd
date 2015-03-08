FROM ubuntu:14.04
MAINTAINER takipone<takipone@gmail.com>

# install required packages
RUN apt-get update -y && apt-get install -y \
    autoconf \
    automake \
    autotools-dev \
    bison \
    cython \
    curl \
    g++ \
    git \
    libcunit1-dev \
    libcurl4-openssl-dev \
    libevent-dev \
    libjansson-dev \
    libjemalloc-dev \
    libssl-dev \
    libtool \
    libxml2-dev \
    make \
    pkg-config \
    python3.4-dev \
    rake \
    zlib1g-dev 

# install qrintf from GitHub
RUN cd /usr/local/src/ && \
    git clone https://github.com/h2o/qrintf.git && \
    cd qrintf && \
    make install PREFIX=/usr/local

# install trusterd from GitHub
RUN cd /usr/local/src/ && \
    git clone https://github.com/matsumoto-r/trusterd.git && \
    cd trusterd && \
    make && \
    make install INSTALL_PREFIX=/usr/local

# copy config and documents
COPY conf/trusterd.conf.rb /trusterd-conf/trusterd.conf.rb
COPY htdocs /trusterd-htdocs

# add trusterd execution user
RUN useradd -s /bin/false -d /usr/local trusterd 

# add log directory
RUN mkdir /trusterd-logs

CMD /usr/local/bin/trusterd /trusterd-conf/trusterd.conf.rb
