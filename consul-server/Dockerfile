FROM consul:latest

ENV CONSUL_TEMPLATE_VERSION 0.19.4

RUN apk add --no-cache \
  jq \
  curl

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /
RUN unzip /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mv consul-template /bin/consul-template && \
    chmod +x /bin/consul-template && \
    mkdir -p /etc/consul-template/config.d/templates
