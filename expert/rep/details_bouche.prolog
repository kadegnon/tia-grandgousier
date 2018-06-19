
:- use_module(library(lists)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).

regle_rep(bouche,51,[ que, donne, en , bouche, le, VinNom], Rep) :-
    rep_bouche(VinNom,Rep).
    
regle_rep(bouche,51,[ que, donne, le, VinNom, en , bouche ], Rep) :-
    rep_bouche(VinNom,Rep).

rep_bouche(VinNom,Rep) :-
   db_vin(VinID,VinNom,_,_,_,_), !,
   rep_vin_bouche(VinID, Rep).


regle_rep(bouche,5,_, [Rep]) :- !,
    reponse(pas_de_vin, Rep).

rep_vin_bouche(VinId, [Mots]) :- 
	db_bouche(VinId,Mots),
	\+length(Mots, 0).

rep_vin_bouche(_, [[aucune, bouche, renseigne, pour, ce, vin]]).