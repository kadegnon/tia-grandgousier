
:- use_module(library(lists)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).


regle_rep(cuisiner,61, [pour, noel, jenvisage, de, cuisiner, du, Plat | _] , Rep) :- !,
	findall(PlatID, get_plat(Plat, PlatID), Plats),
    db_vins_plat(Plat, LVinID),
    rep_lvins_avec(LVinID, Rep).

regle_rep(cuisiner,62,_,[[plat, inconnue, dans, notre, catalogue]]).

get_plat(Plat, PlatID) :-
	plat(PlatID, PlatNom, PlatType),
	(
		(atomic_list_concat(LN, ' ', PlatNom), member(Plat, LN)) % Cherche dans le nom du plat
		;(atomic_list_concat(LT, ' ', PlatType), member(Plat, LT)) % Cherche dans les types du plat,
	).


rep_lvins_avec([], [[aucun, vin, accompagne, pour, ce, plat]]).

rep_lvins_avec(LVinID, [ Resp | L]) :- 
    random_select(VinID, LVinID, _),
    db_vin(VinID,_,_,_,_,Col),
    db_nez(VinID, Nez),
    db_bouche(VinID, Bouche),

    reponse(oui_conseille, Oui),
    append(Oui, [idealement, un, vin, Col], R1),
    append(R1, Nez, R2),
    append(R2, Bouche, R3),
    append(R3, ['.',par,exemple, ' : '], Resp),

    group_by_appellation(LVinID,LVinByAppellations),
	rep_litems_vin_avec(LVinByAppellations, L).

group_by_appellation([], []).
group_by_appellation(LVins, Group) :- 
    get_vins_et_appellation(LVins, List),
    group_by(List, [], Group).

get_vins_et_appellation([], []).
get_vins_et_appellation([ VinId | T], [(Appel, Nom) | L ]) :-
    db_vin(VinId,Nom,_,_,A,_), appellation(A, Appel),
    get_vins_et_appellation(T, L).
    
group_by([], Group, Group).
group_by([(Appel, Vin) | T], Acc, Group) :-
    find_match(Appel, T, Match),
    collect([(Appel, Vin)|Match], LVinNoms),
    subtract(T, Match, Rest),
    group_by(Rest, [(Appel, LVinNoms) | Acc], Group).

collect([], []).
collect([(_, Vn) | T], [Vn | Rs ] ):-   collect(T, Rs).

find_match(_, [], []).
find_match(A, [(A, V) | T], [(A, V) | R]):-  find_match(A, T, R).
find_match(A, [(_, _) | T], R) :-  find_match(A, T, R).


rep_litems_vin_avec([], []) :- !.
rep_litems_vin_avec([ (Appel, LVinNoms) | L], [Irep | Ll]) :-
    atomic_list_concat(LVinNoms, ', ', Noms),
    Irep = [ Noms, '(', Appel, ')' ],
    rep_litems_vin_avec(L,Ll).

