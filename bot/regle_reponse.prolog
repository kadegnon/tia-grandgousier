
:- use_module(library(lists)).


:- ensure_loaded('./db.prolog').


:- multifile produire_reponse:regle_rep/4.




reponse(non, [ non, '.' ]).
reponse(oui_dispose, [oui , ',', je , dispose, de , ':', '\n']).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).


:- load_files([
	'./rep/selon_intervalle_prix'

], [if(not_loaded)]).
