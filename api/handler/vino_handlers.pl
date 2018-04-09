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


error_msg(not_found, 404).



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
  % gspy(vino),
	catch(
		(vino(Method, Params, Url, Response),reply_json_dict(Response)),
		E,(send_error_reply(E))
	).


vino(get, Params, Url, List) :- !,
	Params >:< _{id:VinoID}, 
	list_vino(VinoID, Vinos),
	inject_url(Vinos, Url, List).

vino(post, Params, Url, Vino) :- !,
	create_vino(Params, VinoID),
	get_short_vino(VinoID, NVino),
	inject_url(NVino, Url, Vino),
	reply_json_dict(Vino).		% Renvoie le nouveau Vino simple en JSON 

vino(put, Params, Url) :- !,
	update_vino(Params, NVinoID),
	get_short_vino(NVinoID, NVino),
	inject_url(NVino, Url, Vino),
	reply_json_dict(Vino).		% Renvoie le nouveau Vino simple sous forme de JSON 

vino(delete, Params, _) :- !,
	delete_vino(Params.id, DVino),
	reply_json_dict(DVino).


	
send_error_reply((Err_Type,Err_Msg)) :-
	error_msg(Err_Type, Code),!,
	reply_json_dict(_{
		error: Err_Msg,
		status: Code
	}, [
		status(Code)
	]).

send_error_reply(_) :-
	reply_json_dict(_{
		error: 'Kaboum !!! Internal Error',
		status: 500,
		cause : 'api'
	}, [
		status(500)
	]).


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
	list_2_obj(List,Obj),
	reply_json_dict(Obj).

circonstances_handler(_) :-
	cors_enable,
	list_circonstances(List),
	list_2_obj(List,Obj),
	reply_json_dict(Obj).

couleurs_handler(_) :-
	cors_enable,
	list_couleurs(List),
	list_2_obj(List,Obj),
	reply_json_dict(Obj).

services_handler(_) :-
	cors_enable,
	list_services(List),
	list_2_obj(List,Obj),
	reply_json_dict(Obj).

plats_handler(_) :-
	cors_enable,
	list_plats(List),
	list_2_obj(List,Obj),
	reply_json_dict(Obj).

list_2_obj([], []).
list_2_obj([(Name, Val) | T], [Obj | T_2_Obj]) :-
	Obj = _{name:Name, value:Val},
	list_2_obj(T, T_2_Obj).
list_2_obj(_, []).