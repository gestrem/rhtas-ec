FROM docker.io/library/golang:latest

COPY . .
RUN go mod download

RUN go build -o ./main

ENV PORT 8080
EXPOSE 8080

CMD [ "./main" ]
