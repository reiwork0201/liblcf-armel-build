FROM arm32v5/debian:buster

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    pkg-config \
    git

WORKDIR /app

COPY ./liblcf /app/liblcf

RUN mkdir -p build && cd build && \
    cmake ../liblcf -DCMAKE_BUILD_TYPE=Release && \
    make -j$(nproc)
