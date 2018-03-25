
:- module(produire_reponse,[
    produire_reponse/2
]).


:- ensure_loaded('./regle_reponse').



%% mclef(mot, priorite).

mclef(bouche,10).
mclef(nez,10).
mclef(prix,10).
mclef(vin,5).
mclef(vins,5).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% produire_reponse(+Questions,-Reponse).
%   
%   Questions : Une liste de mots atomisés
%   Response : Liste de liste de lignes correspondant à la
%              règle définis pour le mot-clef 
%
produire_reponse([fin],[[merci, de, m, '\'', avoir, consulte]]) :- !.
produire_reponse([bye],[[merci, de, m, '\'', avoir, consulte]]) :- !.
produire_reponse([au,revoir],[[merci, de, m, '\'', avoir, consulte]]) :- !.

produire_reponse(L,Rep) :-
   write(L),
   mclef(M,_), member(M,L),
   clause(regle_rep(M,_,Pattern,Rep),Body),
   match_pattern(Pattern,L),
   call(Body), !.


match_pattern(Pattern,Lmots) :-
   nom_vins_uniforme(Lmots,L_mots_unif),
   sublist(Pattern,L_mots_unif).

sublist(SL,L) :- 
   prefix(SL,L), !.
sublist(SL,[_|T]) :- sublist(SL,T).

nom_vins_uniforme(Lmots,L_mots_unif) :-
   L1 = Lmots,
   replace_vin([beaumes,de,venise,2015],beaumes_de_venise_2015,L1,L2),
   replace_vin([les,chaboeufs,2013],les_chaboeufs_2013,L2,L3),
   L_mots_unif = L3.
   
replace_vin(L,X,In,Out) :-
   append(L,Suf,In), !, Out = [X|Suf].
replace_vin(_,_,[],[]) :- !.
replace_vin(L,X,[H|In],[H|Out]) :-
   replace_vin(L,X,In,Out).


