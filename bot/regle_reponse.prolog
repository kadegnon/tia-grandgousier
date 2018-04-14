
:- use_module(library(lists)).


:- ensure_loaded('./db.prolog').


:- multifile produire_reponse:regle_rep/4.



reponse(non, [ non, '.' ]).
reponse(oui_dispose, [oui , ',', je , dispose, de , ':', '\n']).
reponse(non_dispose, [non , ',', je , ne,dispose, pas ,de, vins]).
reponse(pas_de_vin, [ce, vin, n, '\'', existe, pas]).

	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).


:- load_files([
	'./rep/selon_intervalle_prix',
	'./rep/selon_criteres'

], [if(not_loaded)]).
