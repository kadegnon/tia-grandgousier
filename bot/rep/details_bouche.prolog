
:- use_module(library(lists)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).


regle_rep(bouche,3,[ que, donne, le, VinNom, en , bouche ], Rep) :-
   db_vin(VinID,VinNom,_,_,_,_), !,
   rep_vin_bouche(VinID, Rep).

regle_rep(bouche,3,_,Rep) :- !,
    reponse(pas_de_vin, R),
    append(R, [dans, notre, catalogue],Rep).

rep_vin_bouche(VinId, [Mots]) :- 
	db_bouche(VinId,Mots),
	\+length(Mots, 0).

rep_vin_bouche(_, [[aucune, bouche, renseigne, pour, ce, vin]]).