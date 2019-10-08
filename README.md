# fdb-docker-compose-sample

A FDB Docker-compose Sample Project which reproduces a timeout issue I've been running into with FDB and docker-compose. 
Related to https://forums.foundationdb.org/t/dockerized-deployment/1561/7?u=seancarroll

## Running

```bash 
mvn clean package

docker-compose build

docker-compose up
```

