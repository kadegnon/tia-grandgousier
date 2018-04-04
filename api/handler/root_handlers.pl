:- module(root_handlers,[
	help_handler/1,
	list_routes_handler/1,
	say_yello/1
]).
	
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_client)).
:- use_module(library(option)).


help_handler(_) :-  
	format('Content-type: text/plain~n~n'), 
	format('Yelp me please !~n').

list_routes_handler(_) :-  
	format('Content-type: text/plain~n~n'),
	format('All routes available ! ~n').


say_yello(Request) :-
	member(method(post), Request),
	cors_enable,
	http_read_data(Request, List, []),
	reply_json_dict(List).

say_yello(_) :-
	format('Content-type: text/plain~n~n'),
	format('Yello World ! ~n ').
	