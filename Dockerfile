FROM centos:7
MAINTAINER dengyong<yodeng@qq.com>

ARG SOFTDIR=/opt/soft

ENV PATH=$SOFTDIR/miniconda3/bin:$SOFTDIR/miniconda3/envs/py2/bin:$PATH

RUN yum -y install gcc gcc-c++ which zlib-devel openssl-devel make git \
    && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone

COPY pip.conf /root/.pip/
COPY condarc /root/.condarc
ADD https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh ./
RUN chmod +x Miniconda3-latest-Linux-x86_64.sh \
    && ./Miniconda3-latest-Linux-x86_64.sh -b -p $SOFTDIR/miniconda3 \
    && $SOFTDIR/miniconda3/bin/conda create -y -n py2 python=2 \
    && rm -fr Miniconda3-latest-Linux-x86_64.sh $SOFTDIR/miniconda3/pkgs
