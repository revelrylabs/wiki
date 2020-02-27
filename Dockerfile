FROM node:12-alpine

ENV OUTLINE_VERSION="0.40.2"

RUN   apk update \
  &&   apk add ca-certificates wget \
  &&   update-ca-certificates

RUN wget https://github.com/outline/outline/archive/v${OUTLINE_VERSION}.tar.gz \
  && tar -zxvf v${OUTLINE_VERSION}.tar.gz \
  && mv outline-${OUTLINE_VERSION} app \
  && mv app /opt/app

WORKDIR /opt/app

RUN npm install && npm run build:webpack && npm install -g pm2

EXPOSE 3000

RUN NODE_ENV=production pm2 start index.js --name outline
