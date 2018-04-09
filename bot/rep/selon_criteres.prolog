
:- use_module(library(lists)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).



regle_rep(vins, 21, [ quels, vins, de, Appel, avezvous], Rep) :-
    lvins_selon_appellation(Appel, Lvins),
    rep_lvins_criteres(Lvins,Rep).
	
regle_rep(vins, 22, [ quels, vins, de, Origine, avezvous ], Rep) :-
    lvins_selon_origin(Origine, Lvins),
    rep_lvins(Lvins,Rep).

	
%% lvins_selon_appellation(+Appellation, -Lvins).
%
%	Liste les vins selon l' appellation
lvins_selon_appellation(Appel, Lvins) :-
    findall( (Vin,Nom,An,Appel) , db_vin(Id,Nom,An,_,Appel,_), Lvins).
	
	
%% lvins_selon_appellation(+Appellation, -Lvins).
%
%	Liste les vins selon l' appellation
lvins_selon_origin(Origin, Lvins) :-
    findall( (Vin,Nom,An,Origin) , db_vin(Id,Nom,An,Origin,_,_), Lvins).


%% rep_lvins_min_max(+ListVinsId, -Reponse).
%
%     Genere la liste de reponses pour les vins convenants.
rep_lvins_criteres([], [Resp]) :- reponse(non, Resp).
rep_lvins_criteres([H|T], [ Resp | L]) :-  
    reponse(oui_dispose, Resp),
    rep_litems_selon_criteres([H|T],L).

rep_litems_selon_criteres([],[]) :- !.
rep_litems_selon_criteres([(VinId,Nom,An,Critere)|L], [Irep|Ll]) :-
	db_prix(VinId,Prix,_),
	db_nez(VinId,Nez), atomics_to_string(Nez, " ", Mots),
	append(
		[ '- \t ', Nom,'de', An,','],
		[ 'un', 'vin', de , , Critere, Mots, 'à', Prix, 'EUR'],
		Irep
	),
	rep_litems_selon_criteres(L,Ll).

