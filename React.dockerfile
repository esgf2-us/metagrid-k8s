FROM node:fermium-alpine3.15 as builder

COPY metagrid-upstream/frontend /app

WORKDIR /app

RUN yarn install --frozen-lock-file && \
	yarn run build:local

FROM nginxinc/nginx-unprivileged
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html/

CMD ["nginx-debug", "-g", "daemon off;"]