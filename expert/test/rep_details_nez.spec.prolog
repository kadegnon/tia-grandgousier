
 :- include('./_lib/crisp_includes').

:- ensure_loaded('vins.mock').      %% Load all mocks vins

:- ensure_loaded('../regle_reponse').



/*****************************************************************************/
% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).
%
% True  if Reponse = [[]] for incorrect VinNom
% True  if Reponse = [[this,is,an,example, of, 'Nez']]


describe(regle_rep_nez, [
    regle_rep(nez,3,[ quel, nez, presente, le, 'invalid VinNom' ], [[ce, vin, n, '\'', existe, pas,dans,notre,liste]]),
    regle_rep(nez,3,[ quel, nez, presente, le, "Ch. Moulin de Mallet" ], [[ce, vin, n, '\'', existe, pas,dans,notre,liste]]),
    regle_rep(nez,3,[ quel, nez, presente, le, 'Ch. Moulin de Mallet' ], [[tendrement,parfumé]])    
    
]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 



