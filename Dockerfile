FROM node:10 as builder

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

USER node
RUN mkdir ~/.npm-global \
    && mkdir ~/app \
    && npm install -g yarn

WORKDIR /home/node/app

COPY . ./
RUN yarn install --no-cache --frozen-lockfile

RUN yarn build

FROM ghost:2.23.4

LABEL mantainer "renehernandez"

COPY --from=builder /home/node/app/dist  /var/lib/ghost/content/themes/BitKnown