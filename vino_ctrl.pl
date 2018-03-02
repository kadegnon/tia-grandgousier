% Export vino predicats
:- module(vino_ctrl,[
    list/3,
    create/3,
    delete/2,
	init_vino_db/1
]).

:- use_module(library(uuid)).
:- use_module(library(filesex)).
:- use_module(library(persistency)).



/****************************************
*	Base de Connaissance
****************************************/

appellation(bordeaux).
appellation('Vallée du rhone et de Languedoc').
appellation(beaujolais).
appellation(bourgogne).
appellation('Val de Loire').
appellation('vins Blanc').
appellation('Champagne').
appellation(cognac).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Persistent DB
%	On persiste les Vinos crées grace à la librairie (persistency)  
%	
%
% 	Predicat persistent/1 possède 4 autres predicats :
%
%		persitent name(Arg, ...)
%		assert_name(Arg, ...)
%		retract_name(Arg, ...)
%		retractall_name(Arg, ...)
%

:- persistent
		vino(id:string,
			nom:string,
			description:string,
			annee:integer,
			origine:string,
			appelation:string,
			htva:float,
			tvac:float 
		).


init_vino_db(Dir) :-
	make_directory_path(Dir),
	directory_file_path(Dir, 'vinos.db', DB),
	db_attach(DB, []).



%	get(+Vino.Id, -Vino)
%
%	Donne le vino correspondant à l'ID.
%

get(Id, Location, _{id:Id, nom:Nom, url:Url
				 description:Descr, annee:An}) :-
	vino(Id, Nom, Descr, An, Orig, Appel,Htva,Tvac),		% Recup le vino
	directory_file_path(Location, Id, Url). % Contruit l'URL vers le détail de ce vino


%	list(+Vino.Id, -Vino)
%
%	Donne tout les vinos correspondants à l'ID.
%
list(Id, Location, Vino) :-
	nonvar(Id), !, get(Id, Location, Vino).

list(Id, Location, List) :-
	findall(Vino, get(Id, Location, Vino), List).



create(Dict, Location, Vino) :-
	uuid(Uuid), 						% Genere un Uuid
	split_string(Uuid,"-","",[Id|_]),	% Garde ke la 1er partie de l'Uuid
	Dict >:< _{id:Id, nom:Nom, description:Descr, 
				annee:An,		origine:Orig,
				htva:Htva,		tvac:Tvac,
				appellation:Appel}, % Unification partielle

	set_def_value(Nom,  ""),
	set_def_value(Descr, ""),
	set_def_value(Orig, ""),
	set_def_value(An, 	2017),
	set_def_value(Htva, 0.0),
	set_def_value(Tvac, 0.0),
	set_def_value(Appel, ""),
	assert_vino(Id, Nom, Descr, An, Orig, Appel,Htva,Tvac),   % Cree && Persiste le Vino
	get(Id, Location, Vino).

set_def_value(Val,  Default) :- var(Val), !, Val = Default.
set_def_value(_, _).


update(Dict, NVino) :-
	delete(Dict.Id, DVino),
	NVino = DVino.put(Dict),
	create_vino(New, Vino).


delete(Dict, DVino) :-
	get(Dict.Id, DVino),
	retractall_vino(Dict.id, _, _, _).