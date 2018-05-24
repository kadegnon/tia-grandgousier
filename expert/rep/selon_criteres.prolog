
:- use_module(library(lists)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).

regle_rep(vin, 21, [ quel, vin, de, Critere | _], Rep) :- !, 
	rep_critere(Critere, Rep).
regle_rep(vins, 22, [ quels, vins, de, Critere | _], Rep) :-
    rep_critere(Critere, Rep).
	
	
rep_critere(Critere, Rep) :-
	lvins_selon_critere(Critere, Lvins),
    rep_lvins_criteres(Lvins,Rep).
	

	
	
	
%% lvins_selon_critere(+Appellation, -Lvins).
%
%	Liste les vins selon l' appellation
lvins_selon_critere(Critere, Lvins) :-
    findall( (Id,Nom,An,Critere) , get_vin_by(Critere, Id,Nom,An), Lvins).
	


get_vin_by(Critere, Id, Nom, An):- 
	db_vin(Id, Nom, An, Critere, _, _) ; %% Par Origine
	get_vin_by_appellation(Critere, Id, Nom, An). %% Par Appelation

get_vin_by_appellation(Appelation, Id, Nom, An):-	
	appellation(AppelId, AppelNom),
	atomic_list_concat(L, ' ', AppelNom), member(Appelation, L),
	db_vin(Id, Nom, An, _, AppelId, _).


%% rep_lvins_min_max(+ListVinsId, -Reponse).
%
%     Genere la liste de reponses pour les vins convenants.

%% rep_lvins_criteres([],[aucun]).
rep_lvins_criteres([], [Resp, de, ce, genre]) :- reponse(non_dispose, Resp).
rep_lvins_criteres([H|T], [ Resp | L]) :-  
    reponse(oui_conseille, Resp),
    rep_litems_selon_criteres([H|T],L).

rep_litems_selon_criteres([],[]) :- !.
rep_litems_selon_criteres([(VinId,Nom,An,Critere)|L], [Irep|Ll]) :-
	db_prix(VinId,Prix,_),
	db_nez(VinId,Nez), atomics_to_string(Nez,' ', Mots),
	append(
		[ '- \t ', Nom,'de', An,','],
		[ 'un', 'vin', de , Critere, Mots, 'à', Prix, 'EUR'],
		Irep
	),
	rep_litems_selon_criteres(L,Ll).

