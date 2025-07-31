FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    pkg-config \
    git

WORKDIR /app

# liblcf のソースコードをコピー（actions/checkout で取得済みのはず）
COPY ./liblcf /app/liblcf

RUN mkdir -p build && cd build && \
    cmake ../liblcf -DCMAKE_BUILD_TYPE=Release && \
    make -j$(nproc)
