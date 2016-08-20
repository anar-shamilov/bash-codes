#!/usr/bin/env bash

read -p "yaz: " site
cat st | sed -e "s/site/$site/Ig" > $site

