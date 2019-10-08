#! /bin/bash

/app/create_cluster_file.bash
java -Djava.security.egd=file:/dev/./urandom -jar /app/app.jar