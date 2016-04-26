FROM centos:centos6

MAINTAINER Zhangqu Li (513163535@qq.com)


RUN yum -y install mysql-server mysql vim openssh-server openssh-clients sudo java-1.8.0-openjdk-devel wget curl

RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config 
RUN echo "root:lizhangqu" | chpasswd

RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key  
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key  

RUN mkdir /var/run/sshd


#ADD docker-init /usr/bin/docker-init
#RUN chmod +x /usr/bin/docker-init
#RUN /usr/bin/docker-init

ADD docker-start /usr/bin/docker-start
RUN chmod +x /usr/bin/docker-start

#ADD my.cnf /etc/my.cnf

RUN wget http://apache.opencas.org/tomcat/tomcat-7/v7.0.69/bin/apache-tomcat-7.0.69.tar.gz
RUN mkdir /opt/tomcat/
RUN tar -xzvf apache-tomcat-7.0.69.tar.gz -C /opt/tomcat/

RUN rm apache-tomcat-7.0.69.tar.gz

ADD tomcat-users.xml /opt/tomcat/apache-tomcat-7.0.69/conf/tomcat-users.xml


EXPOSE 22 3306 8080

ENTRYPOINT ["/usr/bin/docker-start"]

