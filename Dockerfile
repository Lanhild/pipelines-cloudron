FROM cloudron/base:4.2.0@sha256:46da2fffb36353ef714f97ae8e962bd2c212ca091108d768ba473078319a47f4 AS base

WORKDIR /app/code

ENV ENV=prod \
  PORT=9099

# install python 3.11
RUN apt-get update && \
    add-apt-repository -y ppa:deadsnakes && \
    apt-get install -y --no-install-recommends python3.11 python3.11-venv python3.11-dev python3.11-distutils && \
    rm -rf /usr/bin/python3 && ln -s /usr/bin/python3.11 /usr/bin/python3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
  apt-get install -y gcc build-essential && \
  apt-get clean && \
  rm -rf /var/cache/apt /var/lib/apt/lists

RUN git clone https://github.com/open-webui/pipelines /app/code

RUN pip3 install uv && \
  pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu --no-cache-dir

RUN uv pip install --system -r requirements.txt --no-cache-dir

COPY env.sh.template start.sh /app/pkg/

CMD [ "/app/pkg/start.sh" ]

