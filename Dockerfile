FROM centos:6
MAINTAINER Dylan William Hardison <dylan@mozilla.com>

# we add the rpm rather than pass to yum to take advantage of caching.
# we can change the yum install command without having to re-download this
# which was quite slow on 2016-08-01.
ADD https://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm \
    /mysql-community-release-el6-5.noarch.rpm
COPY rpm_list /rpm_list

ADD https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm /usr/local/bin/cpanm
RUN chmod 755 /usr/local/bin/cpanm

RUN rpm -qa --queryformat '/^%{NAME}$/ d\n' > rpm_fix.sed && \
    sed -f rpm_fix.sed /rpm_list > /rpm_list.clean

RUN yum -y install epel-release && yum clean all
RUN yum -y install /mysql-community-release-el6-5.noarch.rpm && yum clean all
RUN yum -y install `cat /rpm_list.clean` \
    && yum clean all

