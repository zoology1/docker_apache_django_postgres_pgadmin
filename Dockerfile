FROM ubuntu:18.04

RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y apt-utils vim curl apache2 apache2-utils graphviz 
RUN apt-get -y install python3 python3-dev libapache2-mod-wsgi-py3
RUN ln /usr/bin/python3 /usr/bin/python
RUN apt-get -y install python3-pip
RUN ln /usr/bin/pip3 /usr/bin/pip
RUN pip install --upgrade pip
RUN pip install django ptvsd
RUN pip install Pillow django-extensions graphviz djangorestframework google-auth requests psycopg2-binary
COPY ./from/apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./from/apache2/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
COPY ./from/apache2/ports.conf /etc/apache2/ports.conf
EXPOSE 80 443 9880 9843
RUN cd /etc/apache2/sites-available/ && a2ensite default-ssl.conf && a2enmod ssl
CMD ["apache2ctl", "-D", "FOREGROUND"]
