FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
MAINTAINER shaun.azzopardi@gmail.com
RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y wget 
##########
# Installs syfco
RUN wget -qO- https://get.haskellstack.org/ | sh
ENV PATH="/usr/local/bin/:${PATH}"
RUN git clone https://github.com/reactive-systems/syfco.git ./syfco
RUN cd ./syfco && stack install
ENV PATH="/root/.local/bin/:${PATH}"
# Installs strix dependencies
RUN apt-get install software-properties-common -y
RUN apt-get install -y g++ cmake make libboost-dev libboost-program-options-dev libboost-filesystem-dev libboost-iostreams-dev zlib1g-dev
RUN add-apt-repository ppa:openjdk-r/ppa -y && apt-get update
RUN apt-get install -y openjdk-11-jdk
RUN wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.1.0/graalvm-ce-java11-linux-amd64-21.1.0.tar.gz
RUN tar -C /usr/lib/jvm/ -zxvf graalvm-ce-java11-linux-amd64-21.1.0.tar.gz
RUN mv /usr/lib/jvm/graalvm-ce-java11-21.1.0/ /usr/lib/jvm/java-11-graalvm/
RUN cd /usr/lib/jvm && ln -s java-11-graalvm graalvm 
RUN /usr/lib/jvm/java-11-graalvm/bin/gu install native-image
##########
# Installs strix
RUN git clone https://github.com/meyerphi/strix.git ./strix
RUN cd ./strix && git reset --hard fd372cf
RUN echo $(ls -1 ./)
RUN cd ./strix && git submodule init && git submodule update
RUN apt-get install curl
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN apt-get install -y clang
RUN apt -y install vim apt-transport-https dirmngr wget software-properties-common
ENV PATH="/usr/lib/jvm/bin/:${PATH}"
ENV PATH="/usr/lib/jvm/java-11-graalvm/bin/:${PATH}"
# RUN echo 'export PATH=/usr/lib/jvm/:$PATH' >> ~/.bashrc
RUN cd ./strix && cargo build --release
ENV PATH="/strix/target/release/:${PATH}"
ENTRYPOINT ["./strix/scripts/strix_tlsf.sh"]
