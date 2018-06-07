
:- module(produire_reponse,[
    produire_reponse/2
]).


:- ensure_loaded([
	'./regle_reponse',
	'./lire_question',
	'./db'
]).



%% mclef(mot, priorite).

mclef(cuisiner,10).
mclef(prix,10).
mclef(plus,10).
mclef(bouche,10).
mclef(nez,10).
mclef(vin,5).
mclef(vins,5).
mclef(auriez,5).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% produire_reponse(+Questions,-Reponse).
%   
%   Questions : Une liste de mots atomisés
%   Response : Liste de liste de lignes correspondant à la
%              règle définis pour le mot-clef 
%
produire_reponse([fin],[[merci, de, 'm\'avoir', 'consulté']]) :- !.
produire_reponse([bye],[[merci, de, 'm\'avoir', 'consulté']]) :- !.
produire_reponse([au,revoir],[[merci, de, 'm\'avoir', 'consulté']]) :- !.

produire_reponse(L,Rep) :-
   % write(L),
   mclef(M,_), member(M,L),
   clause(regle_rep(M,_,Pattern,Rep),Body),
   match_pattern(Pattern,L),
   call(Body), !.

produire_reponse(_, [['Je', ne, comprends,pas,votre,requete]]) :- !.


match_pattern(Pattern,Lmots) :-
   nom_vins_uniforme(Lmots,L_mots_unif),
   sublist(Pattern,L_mots_unif).

sublist(SL,L) :- 
   prefix(SL,L), !.
sublist(SL,[_|T]) :- sublist(SL,T).


nom_vins_uniforme(Lmots,L_mots_unif) :-
   findall( (Nom, Nom_Atoms)
		,( db_vin(_,Nom,_,_,_,_), lire_question(Nom, Nom_Atoms) )
		,LVins
	),
	replace_vin_acc(LVins, Lmots, L_mots_unif).

replace_vin_acc([], Acc, Acc).    
replace_vin_acc([H | T], Acc, L_mots_unif) :-
    replace_vin(H, Acc, Acc_new),
    replace_vin_acc(T, Acc_new , L_mots_unif).

replace_vin( (Nom, Nom_Atoms), In, Out) :-
   append(Nom_Atoms, Suf, In), !, Out = [Nom | Suf].
replace_vin(_,[],[]) :- !.
replace_vin(Vin,[H|In],[H|Out]) :- replace_vin(Vin, In, Out).