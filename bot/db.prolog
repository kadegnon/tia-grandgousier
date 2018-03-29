:- module(db,[
	init_vin_db/1,
	service/1,
	plat/1,
	appellation/1,
	circonstance/1,
	couleur/1,
	vin/6,
	prix/3,
	nez/2,
	bouche/2,
	description/2
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


vin(Id,Nom,An,Origine,Appellation,Couleur) :-
	with_mutex(vin, vin(Id,Nom,An,Origine,Appellation,Couleur)).


prix(VinId,PrixHtva, PrixTvac) :-
	with_mutex(prix, prix(VinId,PrixHtva, PrixTvac)).


bouche(VinId,Atom_List) :-
	with_mutex(bouche, bouche(VinId,Atom_List)).


nez(VinId,Atom_List) :-
	with_mutex(nez, nez(VinId,Atom_List)).


description(VinId,Atom_List) :-
	with_mutex(description, description(VinId,Atom_List)).
