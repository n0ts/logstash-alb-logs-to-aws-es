FROM docker.elastic.co/logstash/logstash:6.3.1

RUN set -e \
    && logstash-plugin install --version 6.4.0 logstash-output-amazon_es \
    && mkdir /usr/share/logstash/patterns

COPY --chown=logstash:root config/ /usr/share/logstash/config/
COPY --chown=logstash:root patterns/ /usr/share/logstash/patterns/
COPY --chown=logstash:root pipeline/ /usr/share/logstash/pipeline/
