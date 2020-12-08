FROM ubuntu
MAINTAINER me@gmail.com
RUN apt-get update 
RUN apt-get install -y g++ cmake make libboost-dev libboost-program-options-dev libboost-filesystem-dev libboost-iostreams-dev zlib1g-dev openjdk-13-jdk
RUN apt-get install -y wget 
RUN wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.3.0/graalvm-ce-java11-linux-amd64-20.3.0.tar.gz
RUN tar -C /usr/lib/jvm/ -zxvf graalvm-ce-java11-linux-amd64-20.3.0.tar.gz
RUN mv /usr/lib/jvm/graalvm-ce-java11-20.3.0/ /usr/lib/jvm/java-11-graalvm/
RUN cd /usr/lib/jvm && ln -s java-11-graalvm graalvm 
RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-11-graalvm/bin/java 0
RUN /usr/lib/jvm/java-11-graalvm/bin/gu install native-image
RUN echo 'export PATH=/usr/lib/jvm/java-11-graalvm/bin:$PATH' >> ~/.bashrc
RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-11-graalvm/bin' >> ~/.bashrc
RUN echo 'export GRAAL_HOME=/usr/lib/jvm/java-11-graalvm/bin' >> ~/.bashrc
RUN apt-get install -y git
##########
# RUN git clone --recurse-submodules -j8 https://gitlab.lrz.de/i7/strix.git
#### OR ####
RUN wget https://strix.model.in.tum.de/files/strix-20.10.zip
RUN apt-get install unzip
RUN unzip strix-20.10.zip
##########
RUN apt-get install -y build-essential
RUN cd /strix && make
# RUN mv /strix/bin /bin
ENTRYPOINT ["/strix/bin/strix"]
