FROM centos:7
RUN yum -y update
RUN yum -y install httpd
RUN echo "<!DOCTYPE html><html><body bgcolor =pink><h1>Docker app web 3</h1><p>Super site for ITSTEP.</p></body></html>" > /var/www/html/index.html

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
