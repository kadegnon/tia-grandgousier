
:- use_module(library(lists)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).


regle_rep(auriez, 71 , [vous, auriez, un, Vin], Rep):- 
	lvins_selon_critere(Vin, LVins),  %% Definit dans rep/selon_criteres.prolog
	rep_Lvins(LVins, Rep).

regle_rep(plus,72, _, [Rep]) :- !,	reponse(pas_de_vin, Rep).
	

rep_Lvins([], [Rep]):- reponse(non_dispose, Rep).
	
rep_Lvins([H|T], [Rep| L]):-
	reponse(oui_conseille, Rep),
	rep_item_Lvins([H | T], L).
	
rep_item_Lvins([], []) :- !.
rep_item_Lvins([(VinId, Nom, An, _) | L], [Rep|T]):-
	db_prix(VinId, Prix, _),
	append(
		[ '- \t ',Nom, An ],
		['(', Prix, 'EUR', 'la', 'bouteille', ')'],
		Rep
	),	
	rep_item_Lvins(L, T).