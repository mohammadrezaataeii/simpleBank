# build stage
FROM golang:1.23-alpine3.21 AS builder
# declare the working directory inside the image
WORKDIR /app
# copy the source code into the working directory
# the first dot means everything in the current directory where the build command is executed
# the second dot means the working directory where the files and folders are being copied to.
COPY . .
# build the application
# pass in the main entrypoint of the application
RUN go build -o main main.go
RUN apk add curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.18.1/migrate.linux-amd64.tar.gz | tar xvz

# Run stage
FROM alpine:3.21
WORKDIR /app
# copy the binary from the builder stage to the working directory
COPY --from=builder /app/main .
COPY --from=builder /app/migrate.linux-amd64 ./migrate
COPY  db/migration ./migration
COPY start.sh .
COPY wait-for.sh .
COPY app.env .

# expose the port on which the application will be running
EXPOSE 8080
# run the application
CMD ["/app/main"]
ENTRYPOINT ["/app/start.sh"]


#### Build instructions ####
# docker build -t image-name:tag .

#### Run instructions ####
# docker run --name container-name -p 8080:8080 image-name:tag

## set env
# docker run --name container-name -p 8080:8080 -e GIN_MODE=release -e DB_SOURCE=postgresql://root:secret@container-name:5432/simple_bank?sslmode=disable image-name:tag
# docker run --name container-name --network network-name -p 8080:8080 -e GIN_MODE=release image-name:tag


#### network commands ####
# docker container inspect container-name
# docker network ls
# docker network inspect network-name (bridge)
# docker network --help
# docker network create network-name
# docker netwotk connect  network-name container-name