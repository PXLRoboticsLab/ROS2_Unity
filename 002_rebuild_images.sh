#!/bin/bash

docker image rm foxy_unity:latest
docker build -t foxy_unity:latest .
