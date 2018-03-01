:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_path)).
:- use_module(library(option)).


:- use_module(api_handlers,[
    api/1,
    extract_params/2
]).

:- http_handler(api(bot), say_yello, [prefix]).

say_yello(Request) :- format('Yello World ! ~n ').
