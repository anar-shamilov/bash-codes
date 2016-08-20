#!/usr/bin/env bash

Z=$(cat phphtpd)
echo "$Z" >> sshpass -p freebsd ssh root@192.168.80.251:/root/php
