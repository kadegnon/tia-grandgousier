:- module(ggs_handlers,[
    intro_handler/1,
	question_handler/1

]).

:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_parameters)).
:- use_module(library(option)).


:- use_module('../../expert/grandgousier-elm',[
	intro/1 as ggs_intro,
	grandgousier/2 as ggs_question
]).

:- set_setting(http:cors, [get, post]).




/******************************************************
*
*	Handler pour requete vers /grandgousier/intro
*
*******************************************************/

intro_handler(_) :-
	cors_enable,
	ggs_intro(Intro),
	reply_json_dict(Intro).


/******************************************************
*
*	Handler pour requete vers /grandgousier/question
*
*******************************************************/

question_handler(Request) :-
	option(method(options), Request), !,
	cors_enable(Request,[
		methods([get,post])
	]),
	format('~n').				% empty body

question_handler(Request) :-
	cors_enable,
	http_parameters(Request, [ 
		question(Question, [default("fin")])
	]),
	% gspy(ggs),
	ggs(Question).


ggs(Question) :-
	ggs_question(Question, GGSResponse),
	reply_json_dict(_{'reponse' : GGSResponse}).

ggs(_) :-
	Err = 'Invalid or Missing parameter (?question)', 
	reply_json_dict(_{'msg': Err}, [status(400)]).
