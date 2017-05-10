FROM centos:7
MAINTAINER Dylan William Hardison <dylan@mozilla.com>

RUN yum update -y
COPY rpm_list /rpm_list
RUN xargs yum -y install < /rpm_list && \
    yum clean all

RUN wget -q https://s3.amazonaws.com/moz-devservices-bmocartons/bmo_centos7/vendor.tar.gz -O/vendor.tar.gz && \
    tar -C /opt -zxvf /vendor.tar.gz \
        bmo_centos7/local/ \
        bmo_centos7/cpanfile \
        bmo_centos7/cpanfile.snapshot \
        bmo_centos7/LIBS.txt \
        && \
    rm /vendor.tar.gz && \
    mkdir /opt/bmo && \
    mv /opt/bmo_centos7/* /opt/bmo && \
    rmdir /opt/bmo_centos7

ENV TEST_C_LIBS_FILE /opt/bmo/LIBS.txt
COPY test-c-libs.t /test-c-libs.t
RUN prove /test-c-libs.t


