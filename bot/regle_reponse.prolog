
:- use_module(library(lists)).

:- ensure_loaded('./vins').





%% regle_rep(+MotClef,+Priorite,+Question,-Reponse).

regle_rep(bouche,1,
  [ que, donne, le, Vin, en, bouche ],
  Rep ) :-

     bouche(Vin,Rep).


regle_rep(vins,2,
  [ auriezvous, des, vins, entre, X, et, Y, eur ],
  Rep) :-
     lvins_prix_min_max(X,Y,Lvins),
     rep_lvins_min_max(Lvins,Rep).

rep_lvins_min_max([], [[ non, '.' ]]).
rep_lvins_min_max([H|T], [ [ oui, '.', je, dispose, de ] | L]) :-
   rep_litems_vin_min_max([H|T],L).

rep_litems_vin_min_max([],[]) :- !.
rep_litems_vin_min_max([(VinId,P)|L], [Irep|Ll]) :-
   vin(VinId,Appellation),
   Irep = [ '- ', Appellation, '(', P, ' EUR )' ],
   rep_litems_vin_min_max(L,Ll).




lvins_prix_min_max(Min,Max,Lvins) :-
   findall( (Vin,P) , prix_vin_min_max(Vin,P,Min,Max), Lvins ).
   

prix_vin_min_max(Vin,P,Min,Max) :-
   prix(Vin,P),
   Min =< P, P =< Max.


