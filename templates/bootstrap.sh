#!/usr/bin/env bash

#TODO Without a timeout "404 page not found" error happens
sleep 5

docker run -p 8080:8080 -d --name rest "antonfenske/rest-webservice:{{ app_version }}"