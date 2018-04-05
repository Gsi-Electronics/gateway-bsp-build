FROM ubuntu:16.04
MAINTAINER Karim Sammouda <karim.sammouda@agcocorp.com>

RUN apt-get update && \
    apt-get install -y build-essential \
                       curl \
                       wget \
                       qemu-user-static \
                       sudo \
                       git \
                       bc \
                       gawk \
                       wget \
                       git-core \
                       diffstat \
                       unzip \
                       texinfo 
                       gcc-multilib \
                       chrpath \
                       socat \
                       cpio \
                       python \
                       python3 \
                       python3-pip \
                       python3-pexpect \
                       xz-utils \
                       debianutils \
                       iputils-ping \
                       dosfstools \
                       mtools \
                       parted \
                       syslinux \
                       tree

# Add "repo" tool (used by many Yocto-based projects)
RUN curl http://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
RUN chmod a+x /usr/local/bin/repo

# Fix error "Please use a locale setting which supports utf-8."
# See https://wiki.yoctoproject.org/wiki/TipsAndTricks/ResolvingLocaleIssues
RUN apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
        echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
        dpkg-reconfigure --frontend=noninteractive locales && \
        update-locale LANG=en_US.UTF-8

RUN git config --global user.name "Docker Build"
RUN git config --global user.email "noreply@agcocorp.com"

WORKDIR opt
RUN wget http://software-dl.ti.com/processor-sdk-linux/esd/AM335X/03_03_00_04/exports/ti-processor-sdk-linux-am335x-evm-03.03.00.04-Linux-x86-Install.bin && \
    chmod +x ti-processor-sdk-linux-am335x-evm-03.03.00.04-Linux-x86-Install.bin && \
    ./ti-processor-sdk-linux-am335x-evm-03.03.00.04-Linux-x86-Install.bin

RUN wget http://releases.linaro.org/components/toolchain/binaries/5.3-2016.02/arm-linux-gnueabihf/gcc-linaro-5.3-2016.02-x86_64_arm-linux-gnueabihf.tar.xz && \
    tar -xf gcc-linaro-5.3-2016.02-x86_64_arm-linux-gnueabihf.tar.xz

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV PATH=/opt/gcc-linaro-5.3-2016.02-x86_64_arm-linux-gnueabihf/bin:$PATH
