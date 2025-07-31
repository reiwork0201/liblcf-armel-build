FROM arm32v5/debian:bullseye

# sources.listを上書き＋archiveリポジトリ追加
RUN echo "deb http://deb.debian.org/debian bullseye main" > /etc/apt/sources.list && \
    echo "deb http://security.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian bullseye main" >> /etc/apt/sources.list && \
    echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf.d/99no-check-valid-until && \
    apt-get clean && apt-get update --allow-releaseinfo-change && \
    apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
      pkg-config \
      git \
      apt-transport-https \
      ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app/liblcf

RUN git clone --depth=1 https://github.com/EasyRPG/liblcf.git .

RUN mkdir -p build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make -j$(nproc)
