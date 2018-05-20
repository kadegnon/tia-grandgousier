:- module(routes, [
    read_params/2
]).

:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_path)).
:- use_module(library(http/http_client)).
:- use_module(library(option)).


:- use_module('./handler/root_handlers',[
	help_handler/1,
	list_routes_handler/1,
	say_yello/1
]).
	

:- use_module('./handler/ggs_handlers',[
	intro_handler/1,
	question_handler/1
]).

:- use_module('./handler/vino_handlers',[
	vino_handler/2,
	appellations_handler/1,
	circonstances_handler/1,
	couleurs_handler/1,
	plats_handler/1
]).

:- set_setting(http:cors, [*]).

:- multifile http:location/3.
:- dynamic   http:location/3.


/******************************************************
*
*	Creation des URL.
*
*******************************************************/


http:location(api, 				 '/api', []).					% /api
http:location(api_ggs, 			 api(ggs), []).					% /api/ggs/*
http:location(api_vino, 		 api(vino), []).				% /api/vino/*
http:location(api_appellations,	 api(appellations), []).		% /api/appellations
http:location(api_circonstances, api(circonstances), []).		% /api/circonstances
http:location(api_couleurs, 	 api(couleurs), []).			% /api/couleurs
http:location(api_services, 	 api(services), []).			% /api/services
http:location(api_plats, 		 api(plats), []).				% /api/plats



/******************************************************
*
*	Enregistre les handlers --> pour URL.
*
*******************************************************/

:- http_handler(root(.), say_yello, []).						% /
:- http_handler(root(help), help_handler, []).					% /help
:- http_handler(root(list), list_routes_handler, []).			% /list

:- http_handler(api(.), say_yello, []).							% /api

:- http_handler(api_ggs(.), question_handler, []).				% /api/ggs/
:- http_handler(api_ggs(intro), intro_handler, []).				% /api/ggs/intro

:- http_handler(api_vino(.), vino_route_handler, [prefix]).		% /api/vino/*
:- http_handler(api_appellations(.), appellations_handler,[]).
:- http_handler(api_circonstances(.), circonstances_handler,[]).
:- http_handler(api_couleurs(.), couleurs_handler,[]).
:- http_handler(api_services(.), circonstances_handler,[]).
:- http_handler(api_plats(.), plats_handler,[]).



vino_route_handler(Request) :-
	vino_handler(Request,api_vino(.)).


read_params(Request, Dict) :-
	option(content_length(Len), Request), Len > 0, !,
	http_read_json_dict(Request, Dict0,[
		value_string_as(atom)
	]),
	(   request_path_id(Request, ID)
		->  Dict = Dict0.put(id,ID)
		;   Dict = Dict0
	).
read_params(Request, _{id:ID}) :-
	request_path_id(Request, ID), !.
read_params(_, empty{id:_}).

request_path_id(Request, ID) :-
	option(path_info(ID), Request).
%	atom_concat('/', ID, SlashID).
%	atomic_concat(SlashID, '', ID).

