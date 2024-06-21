FROM cloudron/base:4.2.0@sha256:46da2fffb36353ef714f97ae8e962bd2c212ca091108d768ba473078319a47f4 AS base

FROM ghcr.io/open-webui/pipelines:latest AS pipelines

FROM base

WORKDIR /app/code

COPY --from=pipelines ./app ./pipelines 

COPY env.sh.template start.sh /app/pkg/

CMD [ "/app/pkg/start.sh" ]

