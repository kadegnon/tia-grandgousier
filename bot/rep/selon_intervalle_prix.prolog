
:- use_module(library(lists)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).

regle_rep(vins, 11, [ auriezvous, des, vins, entre, X, et, Y, eur ], Rep) :-
    lvins_prix_min_max(X,Y,Lvins),
    rep_lvins_min_max(Lvins,Rep).

	

%% lvins_prix_min_max(+PrixMin, +PrixMax,-Lvins).
%%    Liste les vins dans l'intervalle de prix.
lvins_prix_min_max(Min,Max,Lvins) :-
    findall( (Vin,P) , prix_vin_min_max(Vin,P,Min,Max), Lvins).
   
prix_vin_min_max(Vin,P,Min,Max) :-
    db_prix(Vin,P,_),
    Min =< P, P =< Max.

%% rep_lvins_min_max(+ListVinsId, -Reponse)
%     Genere la liste de reponses pour les vins convenants.
rep_lvins_min_max([], [Resp]) :- reponse(non, Resp).
rep_lvins_min_max([H|T], [ Resp | L]) :-  
    reponse(oui_dispose, Resp),
    rep_litems_vin_min_max([H|T],L).

rep_litems_vin_min_max([],[]) :- !.
rep_litems_vin_min_max([(VinId,P)|L], [Irep|Ll]) :-
   db_vin(VinId,Nom,_,_,Appellation,_),
   Irep = [ '-  ', Nom, '(', Appellation, ') à', P, 'EUR' ],
   rep_litems_vin_min_max(L,Ll).





