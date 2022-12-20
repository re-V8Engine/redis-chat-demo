FROM node:14-alpine

WORKDIR /usr/app/frontend

COPY . ./
RUN yarn install

ENTRYPOINT ["yarn", "start"]
