#!/bin/bash
sudo rm -rf ./pg-data
docker stop mes4u-db
docker run --rm --name mes4u-db -d -v ./pg-data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=mesuser -e POSTGRES_USER=mesuser -e POSTGRES_DB=sdmes -p 5434:5432 postgres:17
sleep 5
cat ./pgschemascript.sql | docker exec -i mes4u-db psql -U mesuser -d sdmes
echo "ALTER DATABASE sdmes SET search_path TO sdmes;" | docker exec -i mes4u-db psql -U mesuser -d sdmes