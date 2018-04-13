
:- use_module(library(lists)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).



regle_rep(vins, 21, [ quels, vins, de, Critere, avezvous], Rep) :-
    lvins_selon_critere(Critere, Lvins),
    rep_lvins_criteres(Lvins,Rep).
	

	
%% lvins_selon_critere(+Appellation, -Lvins).
%
%	Liste les vins selon l' appellation
lvins_selon_critere(Critere, Lvins) :-
    findall( (Id,Nom,An,Critere) , get_vin(Id,Nom,An,Critere), Lvins).
	

get_vin(Id,Nom,An,Appel) :- db_vin(Id,Nom,An,_,Appel,_).

get_vin(Id,Nom,An,Origin) :- db_vin(Id,Nom,An,Origin,_,_).



%% rep_lvins_min_max(+ListVinsId, -Reponse).
%
%     Genere la liste de reponses pour les vins convenants.

%% rep_lvins_criteres([],[aucun]).
rep_lvins_criteres([], [Resp]) :- 
	reponse(non_dispose, R), 
	append(R, [de, ce, genre], Resp).
rep_lvins_criteres([H|T], [ Resp | L]) :-  
    reponse(oui_dispose, Resp),
    rep_litems_selon_criteres([H|T],L).

rep_litems_selon_criteres([],[]) :- !.
rep_litems_selon_criteres([(VinId,Nom,An,Critere)|L], [Irep|Ll]) :-
	db_prix(VinId,Prix,_),
	db_nez(VinId,Nez), atomics_to_string(Nez, " ", Mots),
	append(
		[ '- \t ', Nom,'de', An,','],
		[ 'un', 'vin', de , Critere, Mots, 'à', Prix, 'EUR'],
		Irep
	),
	rep_litems_selon_criteres(L,Ll).

