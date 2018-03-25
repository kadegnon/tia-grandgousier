
:- use_module(library(lists)).


:- ensure_loaded('./db').


:- discontiguous produire_reponse:regle_rep/4.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).

regle_rep(bouche,1, [ que, donne, le, Vin, en, bouche ], Rep ) :-
    get_vin(Id,Vin,_,_,_,_),  get_bouche(Id,Rep).


regle_rep(vins, 2, [ auriezvous, des, vins, entre, X, et, Y, eur ], Rep) :-
    lvins_prix_min_max(X,Y,Lvins),
    rep_lvins_min_max(Lvins,Rep).

%% lvins_prix_min_max(+PrixMin, +PrixMax,-Lvins).
%%    Liste les vins dans l'intervalle de prix.
lvins_prix_min_max(Min,Max,Lvins) :-
    findall( (Vin,P) , prix_vin_min_max(Vin,P,Min,Max), Lvins).
   
prix_vin_min_max(Vin,P,Min,Max) :-
    get_prix(Vin,P,_),
    write(P),
    Min =< P, P =< Max.

%% rep_lvins_min_max(+ListVinsId, -Reponse)
%     Genere la liste de reponses pour les vins convenants.
rep_lvins_min_max([], [[ non, '.' ]]).
rep_lvins_min_max([H|T], [ [ oui, ',', je, dispose, de ] | L]) :-
   rep_litems_vin_min_max([H|T],L).

rep_litems_vin_min_max([],[]) :- !.
rep_litems_vin_min_max([(VinId,P)|L], [Irep|Ll]) :-
   get_vin(VinId,Nom,_,_,Appellation,_),
   Irep = [ '-  ', Nom, ' (', Appellation, ') à', P, ' EUR' ],
   rep_litems_vin_min_max(L,Ll).





