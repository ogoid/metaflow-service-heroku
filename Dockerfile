FROM python:3.7-slim

ARG URL=https://github.com/Netflix/metaflow-service/archive/refs/tags/2.0.5.tar.gz

RUN apt-get update && \
    apt-get install --no-install-recommends -y libpq-dev curl build-essential && \
    mkdir /src && \
    curl -L $URL | tar -xz --strip-components=1 -C /src && \
    cp -r src/services src/setup.* /root && \
    pip install /root && \
    apt-get remove -y build-essential curl && \
    rm -rf /src /var/lib/apt/lists/*

WORKDIR /root

ADD bootstrap.sh /bootstrap.sh

ENV DATABASE_URL=

CMD [ "/bootstrap.sh" ]