FROM alpine:3.20

RUN apk add --no-cache curl ca-certificates apache2-utils

CMD ["sleep", "5000"]