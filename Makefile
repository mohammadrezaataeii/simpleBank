# Define the container name and PostgreSQL version
CONTAINER_NAME = postgres17
POSTGRES_VERSION = latest
DB_URL = "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable"


# Docker run command for PostgreSQL container
postgres:
	docker run --name $(CONTAINER_NAME) --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:$(POSTGRES_VERSION)

# Create a database inside the PostgreSQL container
createdb:
	docker exec -it $(CONTAINER_NAME) createdb --username=root --owner=root simple_bank

# Drop a database inside the PostgreSQL container
dropdb:
	docker exec -it $(CONTAINER_NAME) dropdb simple_bank

# DB migrate

newmigrate:
	migrate create -ext sql -dir db/migration -seq add_users

migrateup:
	migrate -path db/migration -database $(DB_URL) -verbose up

migratedown:
	migrate -path db/migration -database $(DB_URL) -verbose down

migrateup1:
	migrate -path db/migration -database $(DB_URL) -verbose up 1

migratedown1:
	migrate -path db/migration -database $(DB_URL) -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go  github.com/simplebank/db/sqlc Store

# Phony targets to prevent conflicts with file names
.PHONY: postgres createdb dropdb newmigrate migrateup migratedown migrateup1 migratedown1 sqlc test server mock
 