
:- use_module(library(lists)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).


regle_rep(nez,31,[ quel, nez, presente, le, VinNom ],Rep) :-
   db_vin(VinID,VinNom,_,_,_,_), !,
   rep_vin_nez(VinID, Rep).

regle_rep(nez,3,_,[Rep]) :- reponse(pas_de_vin, Rep).

rep_vin_nez(VinId, [Mots]) :- db_nez(VinId,Mots),!.
rep_vin_nez(_, [[aucune, nez, pour, ce, vin]]).