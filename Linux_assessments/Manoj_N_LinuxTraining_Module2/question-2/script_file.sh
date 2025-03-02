#!/bin/bash
echo -e "server =localhost\ndatabase_host = localhost\nport=3306\napi_url = http://localhost:8080\nlog_path = /var/log/localhost\ntimeout = 30" > config.txt
sed 's/localhost/127.0.0.1/g' config.txt > updated_config.txt
