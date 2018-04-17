% Export vin predicats
:- module(vin_ctrl,[
	list_circonstances/1,
	list_appellations/1,
	list_couleurs/1,
	list_services/1,
	list_plats/1,
	create_vin/2,	%% C
	list_vin/2,	%% R
	get_vin/2,	%% R
	get_short_vin/2,%% R
	update_vin/2,	%% U
	delete_vin/2,	%% D
	inject_url/3
]).

:- use_module(library(uuid)).			%% Pour pouvoir creer des ID pour les nv vins

:-ensure_loaded('db.prolog').



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	get(+Vin.Id, -Vin)
%
%	Donne le vin correspondant à l'ID.
%
get_vin(Id, _{id:Id, nom:Nom,couleur:Couleur,
				 nez:Nez, bouche:Bouche, plats : Accompagne,
				 services : Service, annee:An, origine:Orig,
				 description:Descr, appellation:Appel, 
				 htva:Htva,tvac:Tvac}) :-
	db_vin(Id, Nom, An, Orig, Appel,Couleur),		% Recup le vin dynamikement
	db_prix(Id, Htva, Tvac),
	db_description(Id, Descr),
	db_nez(Id, Nez), db_bouche(Id, Bouche),	
	db_avec(Id, Accompagne),
	db_pour(Id, Service).

get_vin(Id,_) :- 
	atomic_concat('Vin not found with Id:', Id, Msg),
	throw((not_found, Msg)).

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	get_short_vin(+Vin.Id, -Vin)
%
%	Donne un version court du vin correspondant à l'ID.
%
get_short_vin(Id, _{id:Id, nom:Nom, couleur:Couleur,
				annee:An, origin:Orig,appellation:Appel}) :-
	!, db_vin(Id, Nom,An, Orig, A,Couleur),
	appellation(Appel, A).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	list(+Vin.Id, -Vin)
%
%	Donne le vin correspondant à l'ID specifié
%
list_vin(Id, Vin) :-
	nonvar(Id), !, get_vin(Id, Vin).

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	list(+Vin.Id, -ListVin)
%
%	Donne tout les vins correspondants à l'ID.
%
list_vin(Id, List) :-
	findall(Vin, get_short_vin(Id, Vin), List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	create(+Vin, -NVin.Id).
%
%	Ajoute un nouveau Vin dans la 'DB'.
%
create_vin(Vin, Id) :-
	
	generate_id(Id), 
	
	Vin >:< _{nom:Nom, 	htva:Htva,
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
	
	% Cree && Persiste le Vin
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
%	inject_url(+Vin, +Url, -NVin).
%
%	Injecte l'URL pour obtenir ce vin.
%
inject_url([],_,[]).

inject_url([Vin | RestVins], Url, [NVin | NRestVins]) :- 
	inject_url(Vin, Url, NVin), 
	inject_url(RestVins, Url, NRestVins), !. 

inject_url(Vin, Url, NVin) :-
	Vin >:< _{id:Id},
	directory_file_path(Url, Id, Location),
	NVin = Vin.put(url, Location). 

%%%
% filter_list(+Predicat,+List,-FilteredList).
%
filter_list(Pred, List, Filtered) :- exclude(Pred, List, Filtered).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	update(+Dict, -Vin)
%
%	Modifie un Vin dans la 'DB'.
%
update_vin(Vin, NVin) :-
	delete_vin(Vin.id, DVin),
	New = DVin.put(Vin),
	create_vin(New, NVin).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	delete(+Dict, -Vin)
%
%	Supprime un  Vin dans la 'DB'.
%
delete_vin(Id, DVin) :-
	get_short_vin(Id ,DVin),
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
	findall( (Appel,Val),appellation(Appel, Val),List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	list(-Couleurs)
%
%	Donne tous les couleurs possibles pour un vin.
%
list_couleurs(List) :- 
	findall( (Col,Val), couleur(Col, Val), List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	list(-Services)
%
%	Donne tous les services possibles pour se servir un vin.
%
list_services(List) :- 
	findall( (Serv,Val), service(Serv, Val), List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	list(-Plats)
%
%	Donne tous les plats possibles pour accompagner un vin.
%
list_plats(List) :- 
	findall((Plat,Val), plat(Plat,Val), List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	list(-Circonstances)
%
%	Donne tous les circonstances possibles pour boire un vin.
%
list_circonstances(List) :- 
	findall( (Cir,Val), circonstance(Cir,Val), List).

