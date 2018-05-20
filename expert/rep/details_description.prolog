
:- use_module(library(lists)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).


regle_rep(plus,4,[pourriezvous,men,dire,plus,sur, VinNom], Rep) :-
    db_vin(VinID,VinNom,_,_,_,_), !,
    rep_vin_description(VinID, Rep).

regle_rep(plus,4,_,Rep) :- !,
    reponse(pas_de_vin, R),
    append(R, [dans, notre, catalogue],Rep).

rep_vin_description(VinId, [List_Descr, List_Nez, List_Bouche]) :- 
    db_description(VinId, List_Descr), !,
    db_nez(VinId, List_Nez), !,
    db_bouche(VinId, List_Bouche), !.
