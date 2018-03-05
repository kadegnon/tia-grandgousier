:- module(server,[
        server/0,
	    server/1				% ?Port
    ]).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(settings)).
:- use_module(library(broadcast)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_path)).
:- use_module(library(http/http_json)).
:- use_module(library(option)).


:- set_setting_default(http:cors, [*]).

http:location(api, '/api', []).
http:location(api_vino, api(vino), []).

:- http_handler(api_vino(.), handle_api, [prefix]).


handle_api(Req) :- 
	spy(request_path_id),
	read_query(Req,Data),
	format('Content-type:text/plain~n~n'),
	reply_json(Data).


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
	option(path_info(ID), Request).
%	atom_concat(/, ID, SlashID).




server :-server(3030).
server(Port) :-
	broadcast(http(pre_server_start)),
	http_server(http_dispatch,[ 
		port(Port),
		workers(16)
	]).

