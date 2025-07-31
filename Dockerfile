FROM arm32v5/debian:bullseye

# 公式リポジトリが使えなくなった時のためにarchiveもsources.listに追加
RUN echo "deb http://deb.debian.org/debian bullseye main" > /etc/apt/sources.list && \
    echo "deb http://security.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian bullseye main" >> /etc/apt/sources.list && \
    echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf.d/99no-check-valid-until && \
    apt-get update && apt-get install -y \
      build-essential \
      cmake \
      pkg-config \
      git \
      apt-transport-https \
      ca-certificates

WORKDIR /app/liblcf

RUN git clone --depth=1 https://github.com/EasyRPG/liblcf.git .

RUN mkdir -p build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make -j$(nproc)
