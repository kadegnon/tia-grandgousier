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
%
list_circonstances(List) :- 
	findall(Cir, circonstance(Cir), List).


%	get(+Vino.Id, -Vino)
%
%	Donne le vino correspondant à l'ID.
%
get(Id, Location, _{id:Id, nom:Nom, url:Url,couleur:Couleur,
				 nez:Nez, bouche:Bouche, plats : Accompagne,
				 services : Service, annee:An, origine:Orig,
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
%	list(+Vino.Id, -ListVino)
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
	
	generate_id(Id), 
	
	Params >:< _{nom:Nom, 		htva:Htva,
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

	create_vin(Id, Nom, An, Orig, Appel, Couleur),   % Cree && Persiste le Vino
	create_prix(Id,Htva,Tvac), create_bouche(Id,Bouche),	create_nez(Id,Nez),
	create_pour(Id, Services), create_avec(Id, Plats), create_description(Id,Descr),
	
	get(Id, Params.url, Vino).

generate_id(Id) :- 
	uuid(Uuid), 						% Genere un Uuid
	split_string(Uuid,"-","",[First|_]),	% Garde ke la 1er partie de l'Uuid
	atom_string(Id,First).

set_def_value(Val,  Default) :- var(Val), !, Val = Default.
set_def_value(_, _).


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
