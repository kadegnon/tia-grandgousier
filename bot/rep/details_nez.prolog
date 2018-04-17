
:- use_module(library(lists)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).


regle_rep(nez,3,[ quel, nez, presente, le, VinNom ],Rep) :-
   db_vin(VinID,VinNom,_,_,_,_), !,
   rep_vin_nez(VinID, Rep).

regle_rep(nez,3,_,[Rep]) :- !,
    reponse(pas_de_vin, R),
    append(R, [dans, notre, liste],Rep).

rep_vin_nez(VinId, [Mots]) :- db_nez(VinId,Mots),!.
