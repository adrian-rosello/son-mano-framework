#!/bin/bash

#
# This script runs the son-mano-slm plugin related tests.
#
# It starts three Docker containers:
# - RabbitMQ
# - MongoDB
# - son-mano-pluginmanager/Dockerfile
#
# It triggers the unittest execution in son-mano-pluginmanager
#

# setup cleanup mechanism
trap "docker kill test.broker; docker kill test.mongo; docker rm test.broker; docker rm test.mongo; docker rm test.pluginmanager" INT TERM EXIT

#  always abort if an error occurs
set -e

echo "test_son-mano-pluginmanager.sh"
# build Docker images
docker build -t test.pluginmanager -f son-mano-pluginmanager/Dockerfile .


# spin up container with broker (in daemon mode)
docker run -d -p 5672:5672 --name test.broker rabbitmq:3
# spin up container with MongoDB (in daemon mode)
docker run -d -p 27017:27017 --name test.mongo mongo
# wait a bit for broker startup
sleep 10
# spin up the plugin manager and run tests
docker run --link test.broker:broker --link test.mongo:mongo --name test.pluginmanager test.pluginmanager py.test -v


echo "done."