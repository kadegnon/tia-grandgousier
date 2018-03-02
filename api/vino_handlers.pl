:- module(vino_handlers,[
    vino_handler/1
]).

:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_path)).
:- use_module(library(option)).


:- use_module('vino_ctrl',[
    list_vino/3      as list_vino,
    create_vino/3    as create_vino,
    delete_vino/2    as delete_vino,
]).



:- multifile http:location/3.
:- dynamic   http:location/3.
http:location(vino, '/vino', []).


:- http_handler(vino(.), vino_handler, []).



vino_handler(Request) :-
	option(method(options), Request), !,
	cors_enable(Request,[
		methods([get,post,patch,delete])
	]),
	format('~n').				% empty body
vino_handler(Request) :-
	read_query(Request, Query),
	cors_enable,
	option(method(Method), Request),
	vino(Method, Query).




/******************************************************
*
*	
*
*******************************************************/


vino(get, Params) :- !,
	http_absolute_uri(vino(.), Url), % Construis l'URl vers /vino
	list_vino(Params.id, Url, List),
	reply_json_dict(List).

vino(post, Params) :- !,
	http_absolute_uri(vino(.), Url), % Construis l'URl vers /vino
	create_vino(Params, Url, NVino),
	reply_json_dict(NVino).		% Renvoie le nouveau Vino complet en JSON 

vino(put, Params) :- !,
	update_vino(Params, NVino),
	reply_json_dict(NVino).		% Renvoie le nouveau Vino complet sous forme de JSON 

vino(delete, Params) :- !,
	delete_vinos(Params.id, DVino),
	reply_json_dict(Vino).

