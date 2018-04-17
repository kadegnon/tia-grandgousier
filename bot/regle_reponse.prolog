
:- use_module(library(lists)).


:- ensure_loaded('./db.prolog').


:- multifile regle_rep/4.



reponse(non, [ non, '.' ]).
reponse(oui_dispose, [oui , ',', je , dispose, de , ':', '\n']).
reponse(non_dispose, [non , ',', je , ne,dispose, pas ,de, vins]).
reponse(pas_de_vin, [ce, vin, n, '\'', existe, pas]).

	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).


:- load_files([
	'./rep/selon_intervalle_prix',
	'./rep/selon_criteres',
	'./rep/details_description',
	'./rep/details_nez',
	'./rep/details_bouche'

], [if(not_loaded)]).
