% Export vino predicats
:- module(vino_ctrl,[
	list_circonstances/1,
	list_appellations/1,
	list_couleurs/1,
	list_services/1,
	list_plats/1,
    create_vino/2,	%% C
    list_vino/2,	%% R
    update_vino/2,	%% U
    delete_vino/2	%% D
]).

:- use_module(library(uuid)).			%% Pour pouvoir creer des ID pour les nv vins

:-ensure_loaded('../bot/db.prolog').


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
%get_short
list_circonstances(List) :- 
	findall(Cir, circonstance(Cir), List).


%	get(+Vino.Id, -Vino)
%
%	Donne le vino correspondant à l'ID.
%
get(Id, Location, _{id:Id, nom:Nom, url:Url,couleur:Couleur,
				 nez:Nez, bouche:Bouche, plat : Accompagne,
				 service : Service, annee:An, origine:Orig,
				 description:Descr, appellation:Appel, 
				 htva:Htva,tvac:Tvac}) :-
	db_vin(Id, Nom, An, Orig, Appel,Couleur),		% Recup le vin dynamikement
	db_prix(Id, Htva, Tvac),
	db_description(Id, Descr),
	db_nez(Id, Nez), db_bouche(Id, Bouche),	
	db_avec(Id, Accompagne), db_pour(Id, Service) ,
	directory_file_path(Location, Id, Url). % Contruit l'URL vers le détail de ce vino


%	get_short(+Vino.Id, -Vino)
%
%	Donne un version court du vino correspondant à l'ID.
%
get_short(Id, Location, _{id:Id, nom:Nom, url:Url, couleur:Couleur,
						annee:An, origin:Orig,appellation:Appel}) :-
	db_vin(Id, Nom,An, Orig, Appel,Couleur),		% Recup le vin dynamikement
	directory_file_path(Location, Id, Url). % Contruit l'URL vers le détail de ce vino



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	list(+Vino.Id, -Vino)
%
%	Donne le vin correspondant à l'ID specifié
%
list_vino(Params, Vino) :-
	nonvar(Params.id), !, get(Params.id, Params.url, Vino).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	list(+Vino.Id, -Vino)
%
%	Donne tout les vinos correspondants à l'ID.
%
list_vino(Params, List) :-
	findall(Vino, get_short(Params.id, Params.url, Vino), List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	create(+Dict,+Location, -Vino)
%
%	Ajoute un nouveau Vino dans la 'DB'.
%
create_vino(Params, Vino) :-
	uuid(Uuid), 						% Genere un Uuid
	split_string(Uuid,"-","",[First|_]),	% Garde ke la 1er partie de l'Uuid
	atom_string(Id,First),
	Params >:< _{nom:Nom, 
				annee:An,		origine:Orig,
				htva:Htva,		tvac:Tvac,
				nez:Nez,		bouche:Bouche, 
				couleur:Couleur,plat:Plats,
				service:Services, appellation:Appel,
				description:Descr
			}, % Unification partielle

	set_def_value(Nom,  ""),
	set_def_value(Orig, ""),
	set_def_value(Couleur, ""),
	set_def_value(An, 	2017),
	set_def_value(Htva, 0.0),
	set_def_value(Tvac, 0.0),
	set_def_value(Appel, ""),
	string_to_atoms(Nez, Nez_Atoms),
	string_to_atoms(Bouche, Bouche_Atoms),
	string_to_atoms(Services, Serv_Atoms),
	string_to_atoms(Plats, Plats_Atoms),
	assert_vin(Id, Nom, An, Orig, Appel, Couleur),   % Cree && Persiste le Vino
	assert_prix(Id,Htva,Tvac), assert_bouche(Id,Bouche_Atoms),	assert_nez(Id,Nez_Atoms),
	assert_pour(Id, Serv_Atoms), assert_accompagne(Id, Plats_Atoms), create_description(Id,Descr),
	get(Id, Params.url, Vino).


set_def_value(Val,  Default) :- var(Val), !, Val = Default.
set_def_value(_, _).

%%%
% str_atoms(ListStr,+ListAtoms).
%
str_atoms([],[]).
str_atoms([H|T], [A|S]) :- atom_string(A,H), str_atoms(T,S).


%%%
% create_pour(+VinId,+ListService).
%
create_pour(VinId, Text) :- str_atoms(Text,As), assert_pour(VinId, As).  
create_pour(_, []).

%%%
% create_accompagne(+VinId,+ListPlat).
%
create_accompagne(VinId, Text) :- str_atoms(Text,As), assert_accompagne(VinId,As), 
create_accompagne(_, []).


%%%
% create_description(+VinId,+Text).
%
is_empty_string(X) :-  (X == " "; X == ""),!.
create_description(VinId, Text) :- 
	str_atoms(Text,As),
	assert_description(VinId, As), 
create_description(_, []).


%%%
% filter_list(+Predicat,+List,-FilteredList).
%
filter_list(Pred, List, Filtered) :- exclude(Pred, List, Filtered).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	update(+Dict, -Vino)
%
%	Modifie un Vino dans la 'DB'.
%
update_vino(Params, NVino) :-
	delete_vino(Params, DVino),
	New = DVino.put(Params),
	create_vino(New, NVino).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	delete(+Dict, -Vino)
%
%	Supprime un  Vino dans la 'DB'.
%
delete_vino(Params, DVino) :-
	get(Params.id, Params.url ,DVino),
	delete_prix(Params.id),
	delete_pour(Params.id),
	delete_avec(Params.id),
	delete_bouche(Params.id),
	delete_nez(Params.id),
	delete_description(Params.id),
	delete_vin(Params.id).