FROM alpine:latest
RUN apk update && apk add curl--no-cache curl

COPY myscript.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/myscript.sh

CMD while true; do /usr/local/bin/myscript.sh; sleep 30; done;
