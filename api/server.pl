:- module(server,[
	server/0,
	server/1				% ?Port
]).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(settings)).
:- use_module(library(broadcast)).


%% All routes to /api/*
:- ensure_loaded(api_handler).


%% All routes to /*
:- ensure_loaded(root_handler).


:- set_setting_default(http:cors, [*]).



server :-server(3030).
server(Port) :-
	http_server(http_dispatch,[ 
		port(Port),
		workers(16)
	]).

