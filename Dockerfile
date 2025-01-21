FROM golang:1

WORKDIR /work
ADD go.mod main.go /work
RUN go get . && go build -o /shorten .

FROM debian

COPY --from=0 /shorten /shorten

ENTRYPOINT [ "/shorten" ]
