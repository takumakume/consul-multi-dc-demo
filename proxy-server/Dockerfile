FROM nginx:latest

ENV CONSUL_VERSION 1.0.1
ENV CONSUL_TEMPLATE_VERSION 0.19.4

RUN apt-get update && apt-get -y install \
  curl \
  unzip \
  ca-certificates

ADD https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip /
RUN unzip /consul_${CONSUL_VERSION}_linux_amd64.zip && \
    mv consul /bin/consul && \
    chmod +x /bin/consul && \
    mkdir -p /etc/consul.d

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /
RUN unzip /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mv consul-template /bin/consul-template && \
    chmod +x /bin/consul-template && \
    mkdir -p /etc/consul-template/config.d/templates

RUN echo '{\n\
  "node_name": "__hostname__",\n\
  "data_dir": "/opt/consul",\n\
  "log_level": "DEBUG",\n\
  "enable_debug": true,\n\
  "retry_join": [\n\
    "10.10.11.111",\n\
    "10.10.11.112",\n\
    "10.10.11.113"\n\
  ]\n\
}' > /etc/consul.d/config.json

RUN echo '{\n\
  "service": {\n\
    "name": "proxy-server",\n\
    "tags": ["nginx"],\n\
    "address": "__ipaddress__",\n\
    "port": 80\n\
  }\n\
}' > /etc/consul.d/service.json

RUN echo '{\n\
  "checks": [\n\
    {\n\
      "name": "http port 80",\n\
      "http": "http://__ipaddress__",\n\
      "interval": "3s",\n\
      "timeout": "1s"\n\
    }\n\
  ]\n\
}' > /etc/consul.d/checks.json

CMD sed -i s/__hostname__/${NAME}/g /etc/consul.d/*.json && \
    sed -i s/__ipaddress__/${IPADDRESS}/g /etc/consul.d/*.json && \
    nginx && \
    consul agent -config-dir=/etc/consul.d
