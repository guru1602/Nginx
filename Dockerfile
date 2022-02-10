FROM nginx:latest
RUN apt-get update -y && \ 
    apt-get intall nano vim -y

COPY index.html /var/www/html
COPY custom.conf /etc/nginx/conf.d/custom.conf
WORKDIR /etc/nginx
