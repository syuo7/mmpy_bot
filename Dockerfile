FROM python:3-slim

RUN apt-get update && apt-get install -y curl \
  && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /home/app/
COPY . /home/app
RUN pip install -r /home/app/requirements.txt
WORKDIR /home/app/
COPY entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

RUN curl -L https://github.com/rancher/giddyup/releases/download/v0.19.0/giddyup -o /usr/bin/giddyup \
    && chmod u+x /usr/bin/giddyup

ENTRYPOINT ["/entrypoint.sh"]



