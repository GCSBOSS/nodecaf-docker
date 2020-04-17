FROM node:13-alpine

WORKDIR /cli
RUN npm i -P nodecaf-cli
RUN mkdir /dist
RUN cp -r ./node_modules/nodecaf-cli/bin /dist/
RUN cp -r ./node_modules/nodecaf-cli/lib /dist/
RUN cp -r ./node_modules /dist/
RUN ls /dist

FROM node:13-alpine

ENV NODE_ENV production
ENV APP_PATH /app

WORKDIR /app

ENTRYPOINT ["node", "/cli/bin/nodecaf.js", "run"]

COPY --from=0 /dist /cli

RUN addgroup -g 2000 -S nodecaf && \
    adduser -u 2000 -S nodecaf -G nodecaf && \
    chown nodecaf:nodecaf /app

USER nodecaf
