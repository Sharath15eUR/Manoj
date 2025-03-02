#!/bin/bash

high_mem_process=$(ps -eo pid,%mem --sort=-%mem | awk 'NR==2 {print $1}')
kill -9 "$high_mem_process"
