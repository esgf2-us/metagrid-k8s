FROM nginxinc/nginx-unprivileged
COPY metagrid-upstream/frontend/build/ /usr/share/nginx/html/
COPY inject_runtime_env_vars.sh /docker-entrypoint.d/
COPY metagrid-upstream/frontend/.envs/.react /docker-entrypoint.d/.prod.env

CMD ["nginx-debug", "-g", "daemon off;"]