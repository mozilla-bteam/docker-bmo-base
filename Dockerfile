FROM centos:6
MAINTAINER Dylan William Hardison <dylan@mozilla.com>

COPY rpm_list /rpm_list
RUN yum -y -q install wget && \
    wget https://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm && \
    yum -y -q install epel-release mysql-community-release-el6-5.noarch.rpm && \
    yum -y -q install `cat /rpm_list` \
    && yum clean all

ADD https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm /usr/local/bin/cpanm
RUN chmod 755 /usr/local/bin/cpanm
COPY cpanfile /tmp/cpanfile
RUN cpanm --notest --skip-satisfied --quiet --installdeps /tmp && rm -rf /root/.cpanm
