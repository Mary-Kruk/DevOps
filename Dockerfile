FROM alpinelatest
RUN apk update && apk add curl--no-cache curl

COPY myscript.sh usrlocalbin
RUN chmod +x usrlocalbinmyscript.sh

CMD while true; do usrlocalbinmyscript.sh; sleep 30; done;
