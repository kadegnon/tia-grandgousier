:- module(db,[
	init_vin_db/1,
	service/1,
	plat/1,
	appellation/1,
	circonstance/1,
	couleur/1,
	db_vin/6,
	db_prix/3,
	db_nez/2,
	db_bouche/2,
	db_description/2
]).

:- use_module(library(persistency)).
:- use_module(library(filesex)). 		%% Pour pouvoir creer le fichier


:-ensure_loaded('./db/service').
:-ensure_loaded('./db/plat').
:-ensure_loaded('./db/appellation').
:-ensure_loaded('./db/circonstance').


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


db_vin(Id,Nom,An,Origine,Appellation,Couleur) :-
	with_mutex(db_vin, vin(Id,Nom,An,Origine,Appellation,Couleur)).


db_prix(VinId,PrixHtva, PrixTvac) :-
	with_mutex(db_prix, prix(VinId,PrixHtva, PrixTvac)).


db_bouche(VinId,Atom_List) :-
	with_mutex(db_bouche, bouche(VinId,Atom_List)).


db_nez(VinId,Atom_List) :-
	with_mutex(db_nez, nez(VinId,Atom_List)).


db_description(VinId,Atom_List) :-
	with_mutex(db_description, description(VinId,Atom_List)).
