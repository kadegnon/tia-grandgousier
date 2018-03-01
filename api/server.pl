% Export server predicats
:- module(server,[ 
	server/0,
	server/1				% ?Port
]).

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(settings)).
:- use_module(library(broadcast)).

use_module('./ctrl/vino_ctrl.pl',[
	init_vino_db/1
]).

:- set_setting_default(http:cors, [*]).

% By default, starts listen on port :8080
server :- server(8080).

server(Port) :-
	% broadcast(http(pre_server_start)),
	http_server(http_dispatch,	
		[
			port(Port),
			workers(16)
		]
	).

% :- listen(http(pre_server_start), init_vino_db(db)).
