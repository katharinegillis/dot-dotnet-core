#!/usr/bin/env bash

sudo apt remove dotnet-sdk-8.0 -y
sudo rm -rf /usr/local/bin/composer
sudo apt-get -y autoremove
