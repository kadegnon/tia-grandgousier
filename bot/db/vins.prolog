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


assert(vin(les_chaboeufs_2013,'Nuits-Saint-Georges 1er Cru', 2013,'normandie' ,'bourgogne_rouge','blanc')).
assert(vin(beaumes_de_venise_2015,'Beaumes de Venise', 2015, 'venise','rhone_rouge','rouge')).
assert(prix(beaumes_de_venise_2015, 12.34, 87.45)).
assert(nez(beaumes_de_venise_2015,[intensement, 'parfumé'])).
assert(bouche(beaumes_de_venise_2015,
  [  'les aromes de fraise, de violette cotoient les nuances' ,
     'de baies de genevrier, de sureau et une delicate touche' ,
     'de fleur d\'oranger. Cette intensite se poursuit en' ,
     'bouche avec des saveurs juteuses, racees et tres elegantes'
  ])).
assert(description(beaumes_de_venise_2015,[ 
  'vignoble situe au sud-est des Dentelles de Montmirail',
  'grand vin'
])).

assert(description(les_chaboeufs_2013,[ 
  'Sur une parcelle escarpée, pierreuse',
  'Superbe'
])).
assert(prix(les_chaboeufs_2013, 32.35, 45.76)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


assert(vin(b477d59c,'Ch. Moulin de Mallet',2014,'dordogne',bordeaux_rouge,'')).
assert(prix(b477d59c,5.66,6.848)).
assert(bouche(b477d59c,['Jolie robe grenat aux reflets rubis'])).
assert(nez(b477d59c,[tendrement,parfumé,tendre])).
assert(pour(b477d59c,[])).
assert(accompagne(b477d59c,[])).
assert(description(b477d59c,['Un jolie vin, classique, polyvalent, avec un bel éventail aromatique et des tannins fins',' Très bel équilibre de l\'ensemble, et un boisé bien intégré'])).
assert(vin('4c23dabc','Ch. La Fleur Baudron',2014,'Lussac-Saint-Emilion',bordeaux_rouge,'')).
assert(prix('4c23dabc',6.18,7.47)).
assert(bouche('4c23dabc',['Très plaisant, riche, et de beaux tanins associés à un boisé bien intégré','Un bordeaux très complet'])).
assert(nez('4c23dabc',['aromes de fruits compots','epices fines','nuance florale (violette)'])).
assert(pour('4c23dabc',[])).
assert(accompagne('4c23dabc',[])).
assert(description('4c23dabc',['Magnifique terroir à l\'arrière de Lussac-Saint-Emillion reposant sur des sols graveleuxx et argilocalcaires',' Robe soutenue','Un bordeaux très complet'])).
