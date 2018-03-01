% Export api_handler predicats
:- module(api_handlers,[
    api/1,
    extract_params/2,
    % extract_params/2
]).

:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_path)).
:- use_module(library(option)).


%
%  Add another abstract base location like root
%  this one is files, and we map it to /f,
%  so /f/limburger can be described as files(limburger)
:- multifile http:location/3.
:- dynamic   http:location/3.

http:location(api, '/api', []).

:- http_handler(api(.), say_yello, []).
:- http_handler(api(help), say_yello, []).

say_yello(Request) :- format('Yow World ! ~n ').

%%	extract_params(+Request, -Map).
%
%	Recupere les paremetre URL de la requete.
%	Contient 2 cas possibles :
%
%	  - Tjrs envoyé en JSON. http_read_json_dict lance une erreur s'il fail.
%	  - The TODO =id= may be appended to the path.  In that
%	    case there is path_info(Text) in the Request.  We need
%	    to strip the leading '/'.
%


extract_params(Request, Dict) :-
	option(content_length(Len), Request), Len > 0, !, % Check si vide
	http_read_json_dict(Request, Dict0),
	(   request_path_id(Request, Id)
            ->  Dict = Dict0.put(id,Id)
            ;   Dict = Dict0
	).
extract_params(Request, _{id:Id}) :-request_path_id(Request, Id), !.
extract_params(_, empty{id:_}).

request_path_id(Request, Id) :-
	option(path_info(SlashId), Request),
	atom_concat(/, Id, SlashId).


% extract_params(Request, _{id:Id}) :-
%     member(method(post), Request), !,
%     http_read_data(Request, Data, []),
%     http_parameters(Request,
%                     [ id(Id), nom(Nom), age(Age)],
%                     [ attribute_declarations(param)]
%     ).