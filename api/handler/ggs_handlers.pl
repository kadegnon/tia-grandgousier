:- module(ggs_handlers,[
    intro_handler/1,
	question_handler/1

]).

:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_parameters)).
:- use_module(library(option)).


:- use_module('../../bot/grandgousier-elm',[
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
	reply_json_dict(Intro).				% empty body


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
	option(method(Method), Request),
	ggs(Method, Request).

ggs(get, _).

/*
ggs(get, Request) :- !,
	http_parameters(Request, [ 
		question1(Question, [ optional(true), string ])
	]),
	ggs_question(Question, Response)
	reply_json_dict(Response).

ggs(post, Request) :- !,
	option(content_length(Len), Request), Len > 0, !,
	http_read_json_dict(Request, Params,[]),
	ggs_question(Params.question, Response)
	reply_json_dict(Response).

*/
