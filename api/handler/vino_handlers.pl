:- module(vino_handlers,[
    vino_handler/2,
	appellations_handler/1,
	circonstances_handler/1,
	couleurs_handler/1,
	services_handler/1,
	plats_handler/1

]).

:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_path)).
:- use_module(library(option)).


:- use_module('../vino_ctrl').

:-use_module('../routes',[
	read_params/2
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
	format('~n').				% empty body
vino_handler(Request,Uri) :-
	read_params(Request, Params),
	cors_enable,
	option(method(Method), Request),
	http_absolute_uri(Uri, Url), % Construis l'URl vers api/vino/
	vino(Method, Params, Url).


vino(get, Params, Url) :- !,
	list_vino(Params, Vinos),
	inject_url(Vinos, Url, List),
	reply_json_dict(List).

vino(post, Params, Url) :- !,
	create_vino(Params, VinoID),
	get_short_vino_vino(VinoID, NVino),
	inject_url(NVino, Url, Vino),
	reply_json_dict(Vino).		% Renvoie le nouveau Vino complet en JSON 

vino(put, Params, Url) :- !,
	update_vino(Params, NVino),
	inject_url(NVino, Url, Vino),
	reply_json_dict(Vino).		% Renvoie le nouveau Vino complet sous forme de JSON 

vino(delete, Params, _) :- !,
	delete_vino(Params, DVino),
	reply_json_dict(DVino).


/******************************************************
*
*	Handler pour requete vers les listings 
*		/appellations
*		/plats
*		...
*
*******************************************************/


appellations_handler(_) :-
	cors_enable,
	list_appellations(List),
	reply_json_dict(List).

circonstances_handler(_) :-
	cors_enable,
	list_circonstances(List),
	reply_json_dict(List).

couleurs_handler(_) :-
	cors_enable,
	list_couleurs(List),
	reply_json_dict(List).

services_handler(_) :-
	cors_enable,
	list_services(List),
	reply_json_dict(List).

plats_handler(_) :-
	cors_enable,
	list_plats(List),
	reply_json_dict(List).

