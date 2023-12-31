FROM alpine:3.17
EXPOSE 8545
EXPOSE 8546
EXPOSE 8551
EXPOSE 30303
EXPOSE 30303/udp
CMD "/cliquebait/run.bash"
ARG GETH_VERSION
ENV GETH_VERSION=$GETH_VERSION
RUN \
  apk add --update bash git go make gcc musl-dev linux-headers curl jq         && \
  git clone --branch $GETH_VERSION https://github.com/ethereum/go-ethereum     && \
  (cd go-ethereum && make all)                                                 && \
  cp go-ethereum/build/bin/geth go-ethereum/build/bin/bootnode /usr/local/bin/ && \
  apk del git go make gcc musl-dev linux-headers                               && \
  rm -rf /go-ethereum && rm -rf ~/.cache && rm -rf ~/go                        && \
  rm -rf /var/cache/apk/* && rm -rf /cliquebait/.git

COPY . /cliquebait
