
:- use_module(library(lists)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).


regle_rep(auriez, 71 , [vous, auriez, un, Vin], Rep):- 
	graves(Vin, GVin), 
	rep_Gvins(GVin, Rep).


graves(Graves, Gvin):- 
	findall((Id, Nom, An), get_vin(Id, Nom, An, Graves), Gvin).

get_vin_by(Id, Nom, An, Critere):- db_vin(Id, Nom, An, _, Critere, _) ; db_vin(Id, Nom, An, Critere, _, _).


regle_rep(plus,4,_,[Rep]) :- !,	reponse(pas_de_vin, Rep).
	

rep_Gvins([], [Rep]):- reponse(non_dispose, Rep).
	
rep_Gvins([H|T], [Rep| L]):-
	reponse(oui_conseille, Rep),
	rep_item_Gvins([H | T], L).
	
	
rep_item_Gvins([], []) :- !.
rep_item_Gvins([(VinId, Nom, An) | L], [Rep|T]):-
	db_prix(VinId, Prix, _),
	append(
		[ '- \t ',Nom, An ],
		['(', Prix, 'EUR', 'la', 'bouteille', ')'],
		Rep
	),	
	rep_item_Gvins(L, T).