FROM ubuntu
MAINTAINER shaun.azzopardi@gmail.com
RUN apt update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:openjdk-r/ppa  
RUN apt-get install -y g++ cmake make libboost-dev libboost-program-options-dev libboost-filesystem-dev libboost-iostreams-dev zlib1g-dev openjdk-13-jdk
RUN apt-get install -y wget 
RUN wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.1.0/graalvm-ce-java11-linux-amd64-21.1.0.tar.gz
RUN tar -C /usr/lib/jvm/ -zxvf graalvm-ce-java11-linux-amd64-21.1.0.tar.gz
RUN mv /usr/lib/jvm/graalvm-ce-java11-21.1.0/ /usr/lib/jvm/java-11-graalvm/
RUN cd /usr/lib/jvm && ln -s java-11-graalvm graalvm 
RUN /usr/lib/jvm/java-11-graalvm/bin/gu install native-image
RUN apt-get install -y git
##########
# Installs strix
RUN git clone https://gitlab.lrz.de/i7/strix.git ./strix
RUN echo $(ls -1 ./)
RUN cd ./strix && git submodule init && git submodule update && make
##########
# Installs syfco
RUN apt-get install -y haskell-stack
RUN git clone https://github.com/meyerphi/syfco.git 
RUN cd ./syfco && stack setup
RUN cd ./syfco && stack build 
RUN cd ./syfco && stack install --local-bin-path "../bin"
###########
## Installs all dependencies, however be warned that some links may not work
# RUN apt-get -y install sudo
# RUN apt-get -y install sed
# RUN sed -i 's/apt install/apt -y install/g' /strix/scripts/install_dependencies.sh 
# RUN apt-get -y install gettext
# RUN apt-get -y install clang flex bison patch gzip libxml2
# RUN echo 'export PATH=/root/.local/bin:$PATH' >> ~/.bashrc
# RUN /strix/scripts/install_dependencies.sh 
###########
ENTRYPOINT ["./bin/strix/bin/strix"]
###########
