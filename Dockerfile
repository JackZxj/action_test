FROM nginx:alpine

RUN echo "hello from init version!" > /usr/share/nginx/html/index.html