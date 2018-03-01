:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_path)).
:- use_module(library(option)).

:- use_module(api_handlers,[
    api/1,
    extract_params/2
    % ,extract_params/2
]).

:- use_module('../ctrl/vino_ctrl.pl',[
    list/2       as get_vino,
    create/2    as create_vino,
    delete/1    as delete_vino,
]).


:- http_handler(api(vino), say_advice, []).

say_advice(Request) :- format('Gloups ! Gloups! Drinks or Drive, MUST CHo0ose ! ~n ').


% Handlers pour la route /vino avec chaque methode (GET,POST,PUT,DELETE).

vino(Request) :-
    option(method(options), Request), !, 
	cors_enable(Request,
		    [ methods([get,post,put,delete])
		    ]),
	format('~n'). % Renvoie vide

vino(Request) :-
	extract_params(Request, Params),
    cors_enable,
    option(method(Method), Request), % Chope la methode de la Request
    vino(Method, Request)   % Choisis le predicat correspondant à la method


%	vino(+Method, +Params)
%   Gere la Request GET

vino(get, Params) :- !,
	http_absolute_uri(api(vino), Url), % Construis l'URl vers /vino
	get_vino(Params.id,Vino),		% Appelle le predicat get dans vinoCtrler
	Vino.Url = Url
	reply_json_dict(Vino).		% Renvoie le Vino sous forme de JSON 

vino(post, Params) :- !,
	create_vino(Params, Vino),
	reply_json_dict(Vino).		% Renvoie le nouveau Vino complet en JSON 

vino(put, Params) :- !,
	update_vino(Params, NVino),
	reply_json_dict(NVino).		% Renvoie le nouveau Vino complet sous forme de JSON 

vino(delete, Params) :- !,
	delete(Params.id, Resp),
	retractall_vino(Params.id, _, _, _),
	reply_json_dict(Resp).
