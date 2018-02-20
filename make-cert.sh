#!/bin/sh

openssl genrsa -out server.key 2048

openssl req -new -key server.key -out server.csr -subj "/CN=localhost"

openssl x509 -req -signkey server.key -in server.csr -out server.crt
