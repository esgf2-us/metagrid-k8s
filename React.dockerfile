FROM nginxinc/nginx-unprivileged
COPY build/ /usr/share/nginx/html/

CMD ["nginx-debug", "-g", "daemon off;"]