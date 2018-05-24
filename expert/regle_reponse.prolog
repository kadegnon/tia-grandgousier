
:- use_module(library(lists)).


:- ensure_loaded('./db.prolog').


:- multifile regle_rep/4.



reponse(non, [ 'Non', '.' ]).
reponse(oui_conseille, ['Oui' , ',', je , vous, conseille]).
reponse(oui_dispose, ['Oui' , ',', je , dispose, de , ':', '\n']).
reponse(non_dispose, ['Non' , ',', je , ne,dispose, pas ,de, ce, vin]).
reponse(pas_de_vin, ['Ce', vin, 'n\'est', pas, dans , notre, catalogue]).

	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).

%% Load all regles_rep created

:- ensure_loaded([
	'./rep/selon_intervalle_prix',
	'./rep/selon_criteres',
	'./rep/details_description',
	'./rep/details_nez',
	'./rep/details_bouche',
	'./rep/cuisiner_plat',
	'./rep/auriez_vous_un'

]).
