FROM ubntu:latest
RUN apt -y update
RUN apt -y install apache2
RUN echo "<!DOCTYPE html><html><body bgcolor =pink><h1>Docker app web 3</h1><p>Super site for ITSTEP.</p></body></html>" > /var/www/html/index.html

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
EXPOSE 80
