FROM ubuntu

RUN apt-get update && apt-get upgrade -y
RUN apt-get install unzip -y
RUN apt-get install nginx -y
RUN apt-get install wget -y

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

RUN mkdir -p /swagger

ADD swagger-editor /etc/nginx/sites-available/
RUN cd /etc/nginx/sites-enabled/ && ln -s ../sites-available/swagger-editor
RUN rm -f /etc/nginx/sites-enabled/default
WORKDIR /swagger
RUN wget https://github.com/wordnik/swagger-editor/archive/gh-pages.zip

RUN unzip gh-pages.zip
RUN mv swagger-editor-gh-pages/* .

EXPOSE 80
EXPOSE 443

ENTRYPOINT nginx
