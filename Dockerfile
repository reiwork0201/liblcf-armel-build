FROM arm32v5/debian:buster

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    pkg-config \
    git

WORKDIR /app/liblcf

RUN git clone --depth=1 https://github.com/EasyRPG/liblcf.git .

RUN mkdir -p build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make -j$(nproc)
