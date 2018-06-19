# tia-grandgousier

## Description

Projet de T.I.A, bot conseiller en vins.

To start the grandgousier only throuh through 2 commands :

- ``swipl -s app -g ggs``     : To start only grandgousier

- ``swipl -s app -g api``     : To start the API server on port 8081

It is also possible to launch the API Server as daemon.

1. ``chmod +x daemon.pl``     : Make _daemon.pl_ executable

2. ``./daemon.pl -http=8081`` : Launch the API on port _8081_ as daemon

## Project structure

- ``api`` : API server written in PROLOG, receives HTTP Request through its defined routes and responds with JSON data.

- ``expert`` : Core of Grandgousier

- ``web`` : written with Vue.JS, so it has to be run on a web server.
