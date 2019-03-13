FROM consul
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
COPY certs/localhost.business.com.crt /usr/local/share/ca-certificates/mycert.crt
RUN update-ca-certificates
