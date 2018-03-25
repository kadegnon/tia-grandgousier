:- module(db,[
	init_vin_db/1,
	service/1,
	plat/1,
	appellation/1,
	circonstance/1,
	couleur/1,
	get_vin/6,
	get_prix/3,
	get_nez/2,
	get_bouche/2,
	get_description/2
]).

:- use_module(library(persistency)).
:- use_module(library(filesex)). 		%% Pour pouvoir creer le fichier


:-ensure_loaded('./db/service').
:-ensure_loaded('./db/plat').
:-ensure_loaded('./db/appellation').
:-ensure_loaded('./db/circonstance').

% :- multifile vin/6.
% :- multifile prix/3.
% :- multifile pour/2.
% :- multifile accompagne/2.
% :- multifile nez/2.
% :- multifile bouche/2.
% :- multifile description/2.


:- persistent
		vin(id:atom,
			nom:string,
			millesime:integer,
			origine:string,
			appelation:atom,
			couleur:atom
		),
		prix(id:atom, htva:float,tvac:float),
		pour(id:atom,service:atom),
		accompagne(id:atom,plat:atom),
		nez(id:atom,text:list),
		bouche(id:atom,text:list),
		description(id:atom,text:list).


init_vin_db(Dir) :-
	make_directory_path(Dir),
	directory_file_path(Dir, 'vins.prolog', DB),
	db_attach(DB, []).


get_vin(Id,Nom,An,Origine,Appellation,Couleur) :-
        with_mutex(get_vin, vin(Id,Nom,An,Origine,Appellation,Couleur)).


get_prix(VinId,PrixHtva, PrixTvac) :-
        with_mutex(get_prix, prix(VinId,PrixHtva, PrixTvac)).


get_bouche(VinId,Atom_List) :-
        with_mutex(get_bouche, bouche(VinId,Atom_List)).


get_nez(VinId,Atom_List) :-
        with_mutex(get_nez, nez(VinId,Atom_List)).


get_description(VinId,Atom_List) :-
        with_mutex(get_description, description(VinId,Atom_List)).
