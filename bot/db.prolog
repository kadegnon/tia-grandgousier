:- module(db,[
	init_vin_db/1,
	service/1,
	plat/1,
	appellation/1,
	circonstance/1,
	couleur/1,
	db_vin/6,
	db_prix/3,
	db_pour/2,
	db_avec/2,
	db_nez/2,
	db_bouche/2,
	db_description/2,
	delete_vin/1,
	delete_prix/1,
	delete_pour/1,
	delete_avec/1,
	delete_bouche/1,
	delete_nez/1,
	delete_description/1
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
	vin(Id,Nom,An,Origine,Appellation,Couleur).


db_prix(VinId,PrixHtva, PrixTvac) :-	prix(VinId,PrixHtva, PrixTvac).


db_pour(VinId,Atom_List) :-	pour(VinId,Atom_List).
db_pour(_,[]).


db_avec(VinId,Atom_List) :-	accompagne(VinId,Atom_List).
db_avec(_,[]).


db_bouche(VinId,Atom_List) :-	bouche(VinId,Atom_List).
db_bouche(_,[]).


db_nez(VinId,Atom_List) :-	nez(VinId,Atom_List).
db_nez(_,[]).

db_description(VinId,Atom_List) :-	description(VinId,Atom_List).



delete_vin(Id) :-				retractall_vin(Id,_,_,_,_,_).

delete_prix(VinId) :-			retractall_prix(VinId,_,_).

delete_pour(VinId) :-			retractall_pour(VinId,_).

delete_avec(VinId) :-			retractall_accompagne(VinId,_).


delete_bouche(VinId) :-			retractall_bouche(VinId,_).

delete_nez(VinId) :-			retractall_nez(VinId,_).

delete_description(VinId) :-	retractall_description(VinId,_).
