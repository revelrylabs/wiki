FROM node:12-alpine

ENV OUTLINE_VERSION="0.40.2" \
  URL="https://wiki.revelry-prod.revelry.net" \
  DEPLOYMENT="self" \
  SUBDOMAINS_ENABLED="true" \
  WEBSOCKETS_ENABLED="true" \
  SLACK_MESSAGE_ACTIONS="true" \
  SLACK_APP_ID="AUNSVEESJ" \
  SLACK_KEY="4181489804.974913490902" \
  SENTRY_DSN="https://9dfbfec8803a4534a64a4dda9fe6ce50@sentry.io/3486711"

RUN   apk update \
  &&   apk add ca-certificates wget \
  &&   update-ca-certificates

RUN wget https://github.com/outline/outline/archive/v${OUTLINE_VERSION}.tar.gz \
  && tar -zxvf v${OUTLINE_VERSION}.tar.gz \
  && mv outline-${OUTLINE_VERSION} app \
  && mv app /opt/app

WORKDIR /opt/app

RUN mkdir bin

COPY bin/migrate bin/start ./bin/

RUN chmod +x  ./bin/*

RUN npm install && npm run build:webpack && npm install -g pm2

EXPOSE 5000

CMD ./bin/start
