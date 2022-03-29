# Stage 0, "build-stage", based on Node.js, to build and compile the frontend
FROM packages.aa.com/docker-all/node:16-buster as build-stage
WORKDIR /app
COPY package.json yarn.lock /app/
RUN yarn install
COPY ./ /app/
RUN yarn build

# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM packages.aa.com/docker-all/nginx:1.15
COPY --from=build-stage /app/build/ /usr/share/nginx/html
