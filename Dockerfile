FROM centos:7
MAINTAINER xxjoexx

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

# update yum
RUN yum update -y && \
  yum clean all

# epel,remi
RUN yum install -y epel-release && \
  yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
  yum clean all && \
  sed -i -e "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/epel.repo && \
  sed -i -e "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/remi.repo

# httpd, sshd, scp, openssl, sudo, which
RUN yum install -y httpd httpd-tools openssh-server openssh-clients openssl sudo which && \
  yum clean all

RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime

ADD ./httpd.conf /etc/httpd/conf/httpd.conf

EXPOSE 8080 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
