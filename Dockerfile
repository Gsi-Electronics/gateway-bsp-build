FROM ubuntu:16.04
MAINTAINER Karim Sammouda <karim.sammouda@agcocorp.com>

RUN apt-get update && \
    apt-get install -y build-essential \
                       curl \
                       wget \
                       qemu-user-static \
                       sudo \
                       git \
                       bc

RUN git config --global user.name "Docker Build"
RUN git config --global user.email "noreply@agcocorp.com"

WORKDIR opt
RUN wget http://software-dl.ti.com/processor-sdk-linux/esd/AM335X/03_03_00_04/exports/ti-processor-sdk-linux-am335x-evm-03.03.00.04-Linux-x86-Install.bin && \
    chmod +x ti-processor-sdk-linux-am335x-evm-03.03.00.04-Linux-x86-Install.bin && \
    ./ti-processor-sdk-linux-am335x-evm-03.03.00.04-Linux-x86-Install.bin

RUN wget http://releases.linaro.org/components/toolchain/binaries/5.3-2016.02/arm-linux-gnueabihf/gcc-linaro-5.3-2016.02-x86_64_arm-linux-gnueabihf.tar.xz && \
    tar -xf gcc-linaro-5.3-2016.02-x86_64_arm-linux-gnueabihf.tar.xz

ENV PATH=/opt/gcc-linaro-5.3-2016.02-x86_64_arm-linux-gnueabihf/bin:$PATH
