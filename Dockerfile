FROM christimperley/clang

# install compile-time dependencies
RUN apt-get update && \
    apt-get install -y vim gdb wget zip less

# install nlohmann/json
RUN cd /usr/include && \
    wget https://github.com/nlohmann/json/releases/download/v2.1.1/json.hpp

## portable, internal gcov
#RUN apt-get install -y flex && \
#    cd /tmp && \
#    wget -q https://github.com/gcc-mirror/gcc/archive/gcc-6_3_0-release.tar.gz && \
#    tar -xf gcc-6_3_0-release.tar.gz && \
#    mv gcc-gcc-6_3_0-release gcc && \
#    cd gcc && \
#    ./contrib/download_prerequisites && \
#    mkdir -p /tmp/gcc-build && \
#    cd /tmp/gcc-build && \
#    /tmp/gcc/configure --prefix=/opt/gcov --enable-languages=c,c++ --disable-multilib && \
#    make -j8 && \
#    make install -j8 && \
#    cd / && \
#    rm -rf /tmp/*
#RUN mv /opt/gcov/bin/gcov /opt/gcov/gcov && \
#    rm -rf /opt/gcov/bin /opt/gcov/include /opt/gcov/lib* /opt/gcov/share
#VOLUME /opt/gcov

ADD . /tmp/bond
RUN mkdir /tmp/bond/build && \
    cd /tmp/bond/build && \
    cmake .. && \
    make -j $(nproc)
