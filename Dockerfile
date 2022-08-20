from golang:1.19

RUN apt-get update || exit 0
RUN apt-get install git build-essential -y
RUN mkdir -p /code /mnt/tetrio-metrics-archive /opt/config
# For busting the cache
RUN echo "v2"
RUN git clone https://github.com/benjaminheng/tetrio-metrics.git /code/tetrio-metrics
RUN cd /code/tetrio-metrics && make install
COPY ./config.toml /opt/config/config.toml
WORKDIR /code
VOLUME ["/mnt/tetrio-metrics-archive"]
CMD ["tetrio-metrics"]
