
 :- include('./_lib/crisp_includes').

:- ensure_loaded('vins.mock').      %% Load all mocks vins

:- ensure_loaded('../regle_reponse').



/*****************************************************************************/
% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).
%
% True  if Reponse = [[]] for incorrect VinNom
% True  if Reponse = [[this,is,an,example, of, 'Nez']]


describe(regle_rep_prix, [
    regle_rep(vins,_,
				[auriezvous, des, vins, entre,30, et, 50, eur ], 
				[[non,',',je,ne,dispose,pas,de,vins,dans,cet,intervalle,de,prix,'.']])
/*	,fail-regle_rep(vins,_,
				[auriezvous, des, vins, entre,1, et, 3, eur ], 
				[[non,',',je,ne,dispose,pas,de,vins,dans,cet,intervalle,de,prix,'.']])
	,regle_rep(vins,_,
				[auriezvous,des,vins,entre,5, et,10,eur ], 
				[Rep]),
	length(Rep,1)
*/
]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% regle_rep(+MotClef,+NumRegle,+Question,-Reponse).

/*
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
rep_lvins_min_max([], [Resp]) :- 
	reponse(non_dispose, R),
	append(R, [dans, cet, intervalle, de, prix,'.'], Resp).
	
rep_lvins_min_max([H|T], [ Resp | L]) :-  
    reponse(oui_dispose, Resp),
    rep_litems_vin_min_max([H|T],L).

rep_litems_vin_min_max([],[]) :- !.
rep_litems_vin_min_max([(VinId,P)|L], [Irep|Ll]) :-
   db_vin(VinId,Nom,_,_,A,_),
   appellation(Appel, A),
   Irep = [ '-  ', Nom, '(', Appel, ') à', P, 'EUR' ],
   rep_litems_vin_min_max(L,Ll).



*/

