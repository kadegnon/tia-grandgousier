% Export vino predicats
:- module(vino_ctrl,[
	list_circonstances/1,
	list_appellations/1,
	list_couleurs/1,
	list_services/1,
	list_plats/1,
    create_vino/2,	%% C
    list_vino/2,	%% R
    get_vino/2,	get_short_vino/2,	%% R
    update_vino/2,	%% U
    delete_vino/2,	%% D
	inject_url/3
]).

:- use_module(library(uuid)).			%% Pour pouvoir creer des ID pour les nv vins

:-ensure_loaded('../bot/db.prolog').



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	get(+Vino.Id, -Vino)
%
%	Donne le vino correspondant à l'ID.
%
get_vino(Id, _{id:Id, nom:Nom,couleur:Couleur,
				 nez:Nez, bouche:Bouche, plats : Accompagne,
				 services : Service, annee:An, origine:Orig,
				 description:Descr, appellation:Appel, 
				 htva:Htva,tvac:Tvac}) :-
	db_vin(Id, Nom, An, Orig, Appel,Couleur),		% Recup le vin dynamikement
	db_prix(Id, Htva, Tvac),
	db_description(Id, Descr),
	db_nez(Id, Nez), db_bouche(Id, Bouche),	
	db_avec(Id, Accompagne), db_pour(Id, Service).

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	get_short_vino(+Vino.Id, -Vino)
%
%	Donne un version court du vino correspondant à l'ID.
%
get_short_vino(Id, _{id:Id, nom:Nom, couleur:Couleur,
				annee:An, origin:Orig,appellation:Appel}) :-
	db_vin(Id, Nom,An, Orig, Appel,Couleur).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	list(+Vino.Id, -Vino)
%
%	Donne le vin correspondant à l'ID specifié
%
list_vino(Id, Vino) :-
	nonvar(Id), !, get_vino(Id, Vino).

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	list(+Vino.Id, -ListVino)
%
%	Donne tout les vinos correspondants à l'ID.
%
list_vino(Id, List) :-
	findall(Vino, get_short_vino(Id, Vino), List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	create(+Vino, -NVino.Id).
%
%	Ajoute un nouveau Vino dans la 'DB'.
%
create_vino(Vino, Id) :-
	
	generate_id(Id), 
	
	Vino >:< _{nom:Nom, 		htva:Htva,
				annee:An,		origine:Orig,
				nez:Nez,		bouche:Bouche, 
				couleur:Couleur,plats:Plats,
				services:Services, appellation:Appel,
				description:Descr
			}, % Unification partielle

	set_def_value(Nom,  ''),
	set_def_value(Orig, ''),
	set_def_value(Couleur, ''),
	set_def_value(An, 	2017),
	set_def_value(Htva, 1),
	is(Tvac, Htva * 1.21),
	set_def_value(Appel, ''),
	set_def_value(Services,	[]),
	set_def_value(Plats, 	[]),
	set_def_value(Descr, 	[]),
	set_def_value(Bouche, 	[]),
	set_def_value(Nez, 		[]),
	
	% Cree && Persiste le Vino
	create_vin(Id, Nom, An, Orig, Appel, Couleur),
	create_prix(Id,Htva,Tvac), create_bouche(Id,Bouche),	create_nez(Id,Nez),
	create_pour(Id, Services), create_avec(Id, Plats), create_description(Id,Descr).

	
%	generate_id(-Id).
%
%	Genere suite d'atome aleatoire.
%
generate_id(Id) :- 
	uuid(Uuid), 						% Genere un Uuid
	split_string(Uuid,"-","",[First|_]),	% Garde ke la 1er partie de l'Uuid
	atom_string(Id,First).


%	set_def_value(+TermA, +TermB).
%
%	Essayie d'unifier TermA avec TermB.
%
set_def_value(Val,  Default) :- var(Val), !, Val = Default.
set_def_value([H|T], Default) :- 
	set_def_value(H, Default),
	set_def_value(T, Default).
set_def_value([],  _).
set_def_value(_, _).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	inject_url(+Vino, +Url, -NVino).
%
%	Injecte l'URL pour obtenir ce vino.
%
inject_url([],_,[]).

inject_url([Vino | RestVinos], Url, [NVino | NRestVinos]) :- 
	inject_url(Vino, Url, NVino), 
	inject_url(RestVinos, Url, NRestVinos), !. 

inject_url(Vino, Url, NVino) :-
	Vino >:< _{id:Id},
	directory_file_path(Url, Id, Location),
	NVino = Vino.put(url, Location). 

%%%
% filter_list(+Predicat,+List,-FilteredList).
%
filter_list(Pred, List, Filtered) :- exclude(Pred, List, Filtered).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	update(+Dict, -Vino)
%
%	Modifie un Vino dans la 'DB'.
%
update_vino(Vino, NVino) :-
	delete_vino(Vino.id, DVino),
	New = DVino.put(Vino),
	create_vino(New, NVino).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	delete(+Dict, -Vino)
%
%	Supprime un  Vino dans la 'DB'.
%
delete_vino(Id, DVino) :-
	get_short_vino(Id ,DVino),
	delete_prix(Id),
	delete_pour(Id),
	delete_avec(Id),
	delete_bouche(Id),
	delete_nez(Id),
	delete_description(Id),
	delete_vin(Id).

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	list(-Appellations)
%
%	Donne tous les appellations.
%
list_appellations(List) :-
	findall(Appel,appellation(Appel),List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	list(-Couleurs)
%
%	Donne tous les couleurs possibles pour un vin.
%
list_couleurs(List) :- 
	findall(Col, couleur(Col), List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	list(-Services)
%
%	Donne tous les services possibles pour se servir un vin.
%
list_services(List) :- 
	findall(Serv, service(Serv), List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	list(-Plats)
%
%	Donne tous les plats possibles pour accompagner un vin.
%
list_plats(List) :- 
	findall(Plat, plat(Plat), List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	list(-Circonstances)
%
%	Donne tous les circonstances possibles pour boire un vin.
%
list_circonstances(List) :- 
	findall(Cir, circonstance(Cir), List).

