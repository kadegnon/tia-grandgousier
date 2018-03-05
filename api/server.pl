:- module(server,[
        server/0,
	    server/1				% ?Port
    ]).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(settings)).
:- use_module(library(broadcast)).

:- use_module(vino_ctrl).
:- use_module(api_handlers).
:- use_module(vino_handlers).


:- set_setting_default(http:cors, [*]).



server :-server(8080).
server(Port) :-
	broadcast(http(pre_server_start)),
	http_server(http_dispatch,[ 
		port(Port),
		workers(16)
	]).

:- listen(http(pre_server_start), init_vino_db(data)).
