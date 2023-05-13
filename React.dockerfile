# Pull official base image
FROM node:gallium-alpine3.15 as build

# Set working directory
WORKDIR /app

# Add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# Install app dependencies
COPY package.json ./
COPY yarn.lock ./
RUN yarn install --verbose --frozen-lock-file --network-timeout=1000000

# Add app
COPY . ./
RUN mv .envs/.production/.react.template .envs/.production/.react
RUN echo 'GENERATE_SOURCEMAP=false' >> .envs/.production/.react

RUN yarn build:production

# Build production environment
FROM nginxinc/nginx-unprivileged
COPY --from=build /app/build /usr/share/nginx/html

CMD ["nginx-debug", "-g", "daemon off;"]