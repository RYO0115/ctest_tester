FROM ubuntu:22.04

# Packege Install
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    lcov \
    git \
    wget 

RUN rm -rf /var/lib/apt/lists/*

# GTest Setup

RUN git clone https://github.com/google/googletest.git \
    && cd googletest \
    && mkdir build && cd build \
    && cmake .. \
    && make \
    && make install

# Working Dir Setting
WORKDIR /app