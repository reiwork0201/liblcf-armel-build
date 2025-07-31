FROM arm32v5/debian:bullseye

RUN apt-get update --allow-releaseinfo-change && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    automake \
    autoconf \
    pkg-config \
    libtool \
    libexpat1-dev \
    libicu-dev \
    libinih-dev \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone --depth=1 https://github.com/EasyRPG/liblcf.git

WORKDIR /app/liblcf

RUN autoreconf -i && ./configure --prefix=/usr && make -j$(nproc)

# もしインストールまでやるなら以下も追加
# RUN make install

