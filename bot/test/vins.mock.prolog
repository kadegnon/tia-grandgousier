%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% vin(Id, Nom, Millesime, Origine, Appellation, Couleur).
%%
%% prix(VinId, PrixHtva, PrixTvac).
%%
%% bouche(VinId, Atom_List).
%%
%% nez(VinId, Atom_List).
%%
%% description(VinId, Atom_List).
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


vin(b477d59c,'Ch. Moulin de Mallet',2014,'dordogne',bordeaux_rouge,'').
vin('4c23dabc','Ch. La Fleur Baudron',2014,'Lussac-Saint-Emilion',bordeaux_rouge,'').


prix(b477d59c,5.66,6.848).
prix('4c23dabc',6.18,7.47).

bouche(b477d59c,['Jolie robe grenat aux reflets rubis']).
bouche('4c23dabc',['Très plaisant, riche, et de beaux tanins associés à un boisé bien intégré','Un bordeaux très complet']).

nez(b477d59c,[tendrement,parfumé]).
nez('4c23dabc',['aromes de fruits compots','epices fines','nuance florale (violette)']).

pour(b477d59c,[]).
pour('4c23dabc',[]).

accompagne(b477d59c,[]).
accompagne('4c23dabc',[]).

description(b477d59c,['Un jolie vin, classique, polyvalent, avec un bel éventail aromatique et des tannins fins',' Très bel équilibre de l\'ensemble, et un boisé bien intégré']).
description('4c23dabc',['Magnifique terroir à l\'arrière de Lussac-Saint-Emillion reposant sur des sols graveleuxx et argilocalcaires',' Robe soutenue','Un bordeaux très complet']).


