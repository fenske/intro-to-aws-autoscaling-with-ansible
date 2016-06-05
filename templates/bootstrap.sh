#!/usr/bin/env bash
sleep 5

docker run -p 8080:8080 -d --name rest "antonfenske/rest-webservice:{{ app_version }}"