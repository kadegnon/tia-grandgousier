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

The project contains 3 main folders. You will found below a short description and a link to the corresponding README for more details.

- [``api``](api\README.md) : API server written in PROLOG, receives HTTP Request through its defined routes and responds with JSON data.

- [``expert``](expert\README.md) : Core of Grandgousier , contains the knowledge database, all predicates to respond to the user question.

- [``web``](web/README.md) : WebApp witten in Vue.JS to interract with Grandgousier through a Web interface.


## How to launch?

1. Start the API Server with `swipl` or as daemon. See the [Description](##Descritipon) for details.
    
2. Set the API URL in the web app config.
   Follow the build Setup in the [web/README](web/README.md). 

3. Open the HTTP Server URL in Google Chrome browser.
