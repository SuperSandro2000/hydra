#!/bin/sh

# wait for postgresql to listen
while ! nc -z localhost 64444; do sleep 1; done

createdb -h $(pwd)/.hydra-data/postgres -p 64444 hydra

hydra-init
hydra-create-user alice --password foobar --role admin

touch .hydra-data/hydra.conf
HYDRA_CONFIG=$(pwd)/.hydra-data/hydra.conf exec hydra-server --port 63333
