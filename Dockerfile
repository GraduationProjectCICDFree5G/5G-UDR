FROM free5gc-base AS builder
FROM alpine:3.13.6

LABEL description="Free5GC open source 5G Core Network" \
    version="Stage 3"

ENV GIN_MODE="release"

WORKDIR /free5gc
RUN mkdir -p config/ log/ cert/ udr/

# Copy executable and default certs
COPY --from=builder /free5gc/udr ./udr
COPY --from=builder /free5gc/cert/udr.pem ./cert/
COPY --from=builder /free5gc/cert/udr.key ./cert/
COPY --from=builder /free5gc/config/udrcfg.yaml ./config/

VOLUME [ "/free5gc/config" ]
#VOLUME [ "/free5gc/config/TLS" ]

WORKDIR /free5gc/udr