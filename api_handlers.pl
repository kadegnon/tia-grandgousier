:- module(api_handlers,[
    read_query/2
]).

:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_path)).
:- use_module(library(http/http_client)).
:- use_module(library(option)).

:- multifile http:location/3.
:- dynamic   http:location/3.

http:location(api, '/api', []).


:- http_handler(api(.), say_yello, []).
:- http_handler(root(help), help_handler, []).
:- http_handler(root(list), list_routes_handler, []).


help_handler(Request) :-  
	format('Content-type: text/plain~n~n'), 
	format('Yelp me please !~n').

list_routes_handler(Request) :-  
	format('Content-type: text/plain~n~n'),
	format('All routes available ! ~n').


say_yello(Request) :-
	member(method(post), Request),
	cors_enable,
	http_read_data(Request, List, []),
	reply_json_dict(List).


say_yello(Request) :-
	format('Content-type: text/plain~n~n'),
	format('Yello World ! ~n ').



read_query(Request, Dict) :-
	option(content_length(Len), Request), Len > 0, !,
	http_read_json_dict(Request, Dict0),
	(   request_path_id(Request, ID)
	->  Dict = Dict0.put(id,ID)
	;   Dict = Dict0
	).
read_query(Request, _{id:ID}) :-
	request_path_id(Request, ID), !.
read_query(_, empty{id:_}).

request_path_id(Request, ID) :-
	option(path_info(SlashID), Request),
	atom_concat(/, ID, SlashID).

