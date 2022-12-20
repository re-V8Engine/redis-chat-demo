FROM node:14-alpine

ENV REDIS_ENDPOINT_URL "redis-server:6379"

WORKDIR /usr/app/backend

COPY . ./
RUN yarn install

ENTRYPOINT ["yarn", "start"]
