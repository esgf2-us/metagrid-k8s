FROM nginxinc/nginx-unprivileged
COPY metagrid-upstream/frontend/build/ /usr/share/nginx/html/

CMD ["nginx-debug", "-g", "daemon off;"]