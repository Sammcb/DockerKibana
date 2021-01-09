FROM debian:buster-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
	gnupg2 \
	wget \
	ca-certificates

RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-7.x.list
ENV KB_HOME=/usr/share/kibana
ENV KB_CONF=${KB_HOME}/config
RUN apt-get update && apt-get install -y --no-install-recommends \
	kibana

RUN apt-get purge -y gnupg2 wget ca-certificates && apt-get autoremove -y

RUN mkdir -p ${KB_CONF}
COPY ./kibana.yml ${KB_CONF}/kibana.yml

COPY ./start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 5601

RUN chown -R kibana:kibana ${KB_HOME}
USER kibana

CMD /usr/local/bin/start.sh
