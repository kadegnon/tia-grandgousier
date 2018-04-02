:- module(server,[
	start_server/0,
	start_server/1,				% +Port
	stop_server/0,
	stop_server/1,
	bye/0
]).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_log)).
:- use_module(library(settings)).
:- use_module(library(broadcast)).


:- set_setting_default(http:logfile, './api/http_api.log').


% flag to ensure we only start server once
:- dynamic is_started/0.


%% All routes to /api/*
:- ensure_loaded(api_handler).


%% All routes to /*
:- ensure_loaded(root_handler).


:- set_setting_default(http:cors, [*]).



%%   default_server_port(-Port).
%		Port : the port where the server should listen on
%
default_server_port(3030).


%%	start_server.
%
%	Starts the server if not already done.
%
start_server :-
	is_started,!,
	default_server_port(Port),
	format(user_error, '[SERVER] API already running on http://127.0.0.1:~w/\n', [Port]).

start_server :- 	default_server_port(Port), start_server(Port).

%% start_server(+Port).
% 	 Port : the port to bind the server.
%	
%	Starts the server on the provided port.
%
start_server(Port) :-
	format(user_error, '[SERVER] API starting ... ~n', []),
	http_server(http_dispatch, [
		port(Port),		% Where to listen for request 	[3030]
		workers(6),		% Numbers of Workers threads in the pool [6]
		timeout(180)	% the maximum period of inactivity handling a request [3min]
	]),
	assert(is_started),
	format(user_error, '[SERVER] API started on http://127.0.0.1:~w/~n', [Port]),
	http_log('[SERVER] API started on port :~w~n' , [Port]).


%% 	stop_server.
%
%	Stop the API server if binded to the default port.
%
stop_server :- default_server_port(Port), stop_server(Port).

%%	stop_server(+Port).
%		Port : The port on which the server is binded
%
%	Stop the API server on the provided Port.
%
stop_server(Port) :-
	http_stop_server(Port, []),
	format(user_error, '[SERVER] API stopped on port :~w~n', [Port]),
	http_log('[SERVER] API stopped on port :~w~n' , [Port]).

%% 	bye
%
%  Shut down the server and exit.
%
bye :-	stop_server, halt.


