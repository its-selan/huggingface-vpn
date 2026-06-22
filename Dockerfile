FROM alpine:latest
EXPOSE 7860
RUN apk add --no-cache curl unzip
WORKDIR /app

# Download Xray
RUN curl -L https://github.com/XTLS/Xray-core/releases/download/v26.3.27/Xray-linux-64.zip -o xray.zip && \
    unzip xray.zip && \
    chmod +x xray && \
    rm -rf xray.zip

ENV GOMAXPROCS=1
ENV GOGC=50

CMD echo "{\
  \"log\": {\
    \"loglevel\": \"none\"\
  },\
  \"dns\": {\
    \"servers\": [\"1.1.1.1\", \"8.8.8.8\"]\
  },\
  \"inbounds\": [{\
    \"port\": 7860,\
    \"protocol\": \"vless\",\
    \"settings\": {\
      \"clients\": [{\"id\": \"${UUID:-55d21a2c-9a4f-40be-bd75-ce9099be38d1}\"}],\
      \"decryption\": \"none\"\
    },\
    \"streamSettings\": {\
      \"network\": \"ws\",\
      \"security\": \"none\",\
      \"wsSettings\": {\
        \"path\": \"/vless\"\
      }\
    },\
    \"sniffing\": {\
      \"enabled\": true,\
      \"destOverride\": [\"http\", \"tls\"]\
    }\
  }],\
  \"outbounds\": [{\
    \"protocol\": \"freedom\",\
    \"settings\": {\
      \"domainStrategy\": \"UseIPv4\"\
    }\
  }]\
}" > config.json && ./xray run -c config.json
