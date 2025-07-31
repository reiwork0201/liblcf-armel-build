FROM arm32v5/debian:bullseye

RUN echo "deb http://deb.debian.org/debian bullseye main" > /etc/apt/sources.list && \
    echo "deb http://security.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian bullseye main" >> /etc/apt/sources.list && \
    echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf.d/99no-check-valid-until && \
    apt-get update && apt-get install -y --no-install-recommends \
        git build-essential automake autoconf pkg-config libtool \
        libexpat1-dev libicu-dev libinih-dev ca-certificates && \
    rm -rf /var/lib/apt/lists/*
    
WORKDIR /app

RUN git clone --depth=1 https://github.com/EasyRPG/liblcf.git

WORKDIR /app/liblcf

RUN autoreconf -i && ./configure --prefix=/usr && make -j$(nproc)
