FROM centos:8

RUN dnf install cmake clang flex git make wget libevent libevent-devel openssl openssl-devel bison zlib zlib-devel -y && mkdir /opt/3party
ADD https://dl.bintray.com/boostorg/release/1.71.0/source/boost_1_71_0.tar.gz /opt/3party/boost.tar.gz
ADD https://download.libsodium.org/libsodium/releases/libsodium-1.0.18.tar.gz /opt/3party/sodium.tar.gz
ADD CMakeLists.txt /opt/3party/
RUN cd /opt/3party && tar -zxvf sodium.tar.gz && cd libsodium-1.0.18 && \
	./configure && make -j16 install && \
  cd /opt/3party && tar -zxvf boost.tar.gz && cd boost_1_71_0 && \
	./bootstrap.sh && ./b2 install && \
	cd /opt/3party && cmake . && make -j16 && \
	cd && rm -r /opt/3party
	
