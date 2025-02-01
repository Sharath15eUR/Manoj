#!/bin/bash
echo "Available gateways:"
ip route | awk '/default/ {print $3}' | sort -V
