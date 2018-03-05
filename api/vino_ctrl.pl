% Export vino predicats
:- module(vino_ctrl,[
	list_appellations/1,
    list_vino/2,
    create_vino/2,
    update_vino/2,
    delete_vino/2,
	init_vino_db/1
]).

:- use_module(library(uuid)).
:- use_module(library(filesex)).
:- use_module(library(persistency)).


:-ensure_loaded(appellation).


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
		vino(id:atom,
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


%	list(appellations)
%
%	Donne tous les appellations.
%
list_appellations(List) :-
	findall(Appel,appellation(Appel),List).



%	get(+Vino.Id, -Vino)
%
%	Donne le vino correspondant à l'ID.
%
get(Id, Location, _{id:Id, nom:Nom, url:Url,
				 description:Descr, annee:An, origin:Orig,
				 appelation:Appel,htva:Htva,tvac:Tvac}) :-
	% spy(vino),
	vino(Id, Nom, Descr, An, Orig, Appel,Htva,Tvac),		% Recup le vino dynamikement
	directory_file_path(Location, Id, Url). % Contruit l'URL vers le détail de ce vino


%	list(+Vino.Id, -Vino)
%
%	Donne tout les vinos correspondants à l'ID.
%
list_vino(Params, Vino) :-
	nonvar(Params.id), !, get(Params.id, Params.url, Vino).

list_vino(Params, List) :-
	findall(Vino, get(Params.id, Params.url, Vino), List).


%	create(+Dict,+Location, -Vino)
%
%	Ajoute un nouveau Vino dans la 'DB'.
%
create_vino(Params, Vino) :-
	uuid(Uuid), 						% Genere un Uuid
	split_string(Uuid,"-","",[First|_]),	% Garde ke la 1er partie de l'Uuid
	atom_string(Id,First),
	Params >:< _{nom:Nom, description:Descr, 
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
	get(Id, Params.url, Vino).

set_def_value(Val,  Default) :- var(Val), !, Val = Default.
set_def_value(_, _).


update_vino(Params, NVino) :-
	delete_vino(Params, DVino),
	New = DVino.put(Params),
	create_vino(New, NVino).


delete_vino(Params, DVino) :-
	get(Params.id, Params.url ,DVino),
	retractall_vino(Params.id,_,_,_,_,_,_,_).