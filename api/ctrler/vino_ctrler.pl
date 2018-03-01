% Export vino predicats
:- module(vino_ctrler,[
    list/2 ,
    create/2,
    delete/2,
	init_vino_db/1
]).

:- dynamic          % Ajout du predicat dynamik : vino
    vino/1.

:- use_module(library(uuid)).
:- use_module(library(filesex)).
:- use_module(library(persistency)).

:- [appellation].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Persistent DB
%	On persiste les Vinos crées grace à la librairie (persistency)  
%	
%
% 	Predicat persistent/1 engendre 4 autres predicats :
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
        directory_file_path(Dir, 'vinos.db', DBFile),
        db_attach(DBFile, []).



%	list(+Vino.Id, -Vino)
%
%	Donne tout les vinos correspondants à l'ID.
%   Si l'Id fournit est correct, return le Vion correspondant
%   Sinon, la liste des Vinos
%
list(Id, Vino) :-
	nonvar(Id), !, get(Id, Vino).

list(Id, List) :-
	findall(Vino, get(Id, Vino), List).


%	get(+Vino.Id, -Vino)
%
%	Donne le vino correspondant à l'ID.
%
get(Id, PathUrl, _{id:Id, nom:Nom, url:Url, description:Descr, annee:An}) :-
	vino(Id, Nom, Desc, An),		% Recup le vino
	set_def_value(Path_Url,"").
	directory_file_path(PathUrl, Id, Url). % Contruit l'URL vers le détail de ce vino




%%	create_vino(+Dict, -NewVino).
%
%	Create a new Vino from info in Dict.  %We ignore all data in the
%	dict, except for,  =title=,  =completed=   and  =order=  fields.
%	Missing fields are left unbound, so we   need  to bind them to a
%	default value. Finally, we return the created Vino.

create(Dict, Vino) :-
	uuid(Uuid), 						% Genere un Uuid
	split_string(Uuid,"-","",[Id|_]),	% Garde ke la 1er partie de l'Uuid
	Dict >:< _{id:Id, url:URL, nom:Nom, description:Descr, 
				annee:An,	origine:Orig,
				htva:Htva,	tvac:Tvac,
				appellation:Appel}, % Unification partielle
	set_def_value(Nom,  ""),
	set_def_value(Descr, ""),
	set_def_value(Orig, ""),
	set_def_value(URL, ""),
	set_def_value(An, 2017),
	set_def_value(Htva, 0.0),
	set_def_value(Tvac, 0.0),
	set_def_value(Appel, ""),
	assert_vino(Id, Nom, Descr, An, Orig, Appel,Htva,Tvac),   % Cree && Persiste le Vino
	get_vino(Id, TODO).



set_def_value(Val,  Default) :- var(Val), !, Val = Default.
set_def_value(_, _).


update(Dict, NVino) :-
	delete(Dict.Id, DVino),
	NVino = DVino.put(Dict),
	create_vino(New, Vino).


delete(Dict, DVino) :-
	get(Dict.Id, DVino),
	retractall_vino(Dict.id, _, _, _).