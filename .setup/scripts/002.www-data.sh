#!/usr/bin/env bash

chsh -s /bin/bash www-data
usermod -G crontab -a www-data
