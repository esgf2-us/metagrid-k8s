FROM nginxinc/nginx-unprivileged
COPY default.conf /etc/nginx/conf.d/default.conf
COPY metagrid-upstream/frontend/build/ /usr/share/nginx/html/

CMD ["nginx-debug", "-g", "daemon off;"]