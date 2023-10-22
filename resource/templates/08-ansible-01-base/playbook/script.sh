#!/bin/bash

docker-compose -f /home/alyoshqa/docker/docker-compose.yml up -d 

ansible-playbook site.yml -i inventory/prod.yml 

docker stop centos7 fedora ubuntu
