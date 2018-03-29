:- module(vino_handlers,[
    vino_handler/2,
	appellations_handler/1,
	circonstances_handler/1,
	couleurs_handler/1,
	services_handler/1,
	plats_handler/1

]).

:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_path)).
:- use_module(library(option)).


:- use_module(vino_ctrl,[
	list_circonstances/1,
	list_appellations/1,
	list_couleurs/1,
	list_services/1,
	list_plats/1,
	list_vino/2,
    create_vino/2,
    update_vino/2,
    delete_vino/2
]).

:-use_module(api_handler,[
	read_query/2
]).

:- set_setting(http:cors, [*]).



/******************************************************
*
*	Handler pour requete vers /vino
*
*******************************************************/


vino_handler(Request,_) :-
	option(method(options), Request), !,
	cors_enable(Request,[
		methods([get,post,put,delete])
	]),
	format('Nope to say~n').				% empty body
vino_handler(Request,Uri) :-
	writeln(Uri),
	read_query(Request, Query),
	cors_enable,
	option(method(Method), Request),
	http_absolute_uri(Uri, Url), % Construis l'URl vers api/vino/
	Params = Query.put(url,Url),
	vino(Method, Params).


appellations_handler(Request) :-
	cors_enable,
	list_appellations(List),
	reply_json_dict(List).

circonstances_handler(Request) :-
	list_circonstances(List),
	reply_json_dict(List).

couleurs_handler(Request) :-
	list_couleurs(List),
	reply_json_dict(List).

services_handler(Request) :-
	list_services(List),
	reply_json_dict(List).

plats_handler(Request) :-
	list_plats(List),
	reply_json_dict(List).



vino(get, Params) :- !,
	list_vino(Params, List),
	reply_json_dict(List).

vino(post, Params) :- !,
	create_vino(Params, NVino),
	reply_json_dict(NVino).		% Renvoie le nouveau Vino complet en JSON 

vino(put, Params) :- !,
	update_vino(Params, NVino),
	reply_json_dict(NVino).		% Renvoie le nouveau Vino complet sous forme de JSON 

vino(delete, Params) :- !,
	delete_vino(Params, DVino),
	reply_json_dict(DVino).

