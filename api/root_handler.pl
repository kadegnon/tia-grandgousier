:- module(root_handler).

:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_path)).
:- use_module(library(http/http_client)).
:- use_module(library(option)).


:- set_setting(http:cors, [*]).

:- multifile http:location/3.
:- dynamic   http:location/3.

%% http:location(api, '/api', []). 								%


:- http_handler(root(help), help_handler, []).				
:- http_handler(root(list), list_routes_handler, []).			% /list


help_handler(_) :-  
	format('Content-type: text/plain~n~n'), 
	format('Yelp me please !~n').

list_routes_handler(_) :-  
	format('Content-type: text/plain~n~n'),
	format('All routes available ! ~n').
