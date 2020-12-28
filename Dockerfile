FROM nginx:alpine

RUN echo "hello from v2! It seems worked!" > /usr/share/nginx/html/index.html