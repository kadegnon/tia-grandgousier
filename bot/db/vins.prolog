%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% vin(Id, Nom, Millesime, Origine, Appellation, Couleur).
%%
%% prix(VinId, PrixHtva, PrixTvac).
%%
%% bouche(VinId, Atom_List).
%%
%% nez(VinId, Atom_List_Nez).
%%
%% pour(VinId, Atom_List_Service).
%%
%% accompagne(VinId, Atom_List_Plat).
%%
%% description(VinId, Atom_List).
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


assert(vin(les_chaboeufs_2013,'Nuits-Saint-Georges', 2013,'normandie' ,'bourgogne_rouge','blanc')).
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

assert(vin(fleur_pomys_2012,'La Fleur de Pomys', 2012, 'Sainte-Estephe','bordeaux_rouge','rouge')).
assert(prix(fleur_pomys_2012, 17.65, 21.36)).
assert(nez(fleur_pomys_2012,[empyreumatique, annonce, un, vin,complexe,et, 'concentre'])).
assert(bouche(fleur_pomys_2012,
  [  'les aromes de myrtille et de cassis se melent a des notes glorales et a un boise bien integre',
     'Les saveurs sont riches et concentrees, avec beaucoup de densite' ,
     'la finale laisse le souvenir d\' un Saint-Estephe a la fois complet, dense et race.'
  ])).
assert(description(fleur_pomys_2012,[ 
  'Propriete du Nord du Haut-Medoc reposant aur le terroir argillo-graveleux a l\'origine de vins plus charpentes',
  'La robe est profonde'
])).


assert(vin(chambolle_musigy_2012,'Chambolle-Musigny', 2012, 'Les Noirots','vallee_du_rhone_et_languedoc','rouge')).
assert(prix(chambolle_musigy_2012, 52.77, 63.85)).
assert(nez(chambolle_musigy_2012,[complexe,intense,de,fruits,rouges,'d\'epices (notes de poivres)',meles,a,des,nuances,empyreumatiques,et,de,'sous-bois'])).
assert(bouche(chambolle_musigy_2012,  ['Complexe avec des saveurs denses, concentrees et enrobees'])).
assert(description(chambolle_musigy_2012,['Grand vin opulent, puissant, race et long'])).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


assert(vin(b477d59c,'Ch. Moulin de Mallet',2014,'dordogne',bordeaux_rouge,'rouge')).
assert(prix(b477d59c,5.66,6.848)).
assert(bouche(b477d59c,['Jolie robe grenat aux reflets rubis'])).
assert(nez(b477d59c,[tendrement,parfumé,tendre])).
assert(pour(b477d59c,[])).
assert(accompagne(b477d59c,[canard])).
assert(description(b477d59c,['Un jolie vin, classique, polyvalent, avec un bel éventail aromatique et des tannins fins',' Très bel équilibre de l\'ensemble, et un boisé bien intégré'])).
assert(vin('4c23dabc','Ch. La Fleur Baudron',2014,'Lussac-Saint-Emilion',bordeaux_rouge,'')).
assert(prix('4c23dabc',6.18,7.47)).
assert(bouche('4c23dabc',['Très plaisant, riche, et de beaux tanins associés à un boisé bien intégré','Un bordeaux très complet'])).
assert(nez('4c23dabc',['aromes de fruits compots','epices fines','nuance florale (violette)'])).
assert(pour('4c23dabc',[])).
assert(accompagne('4c23dabc',[confit_oie_ou_canard])).
assert(description('4c23dabc',['Magnifique terroir à l\'arrière de Lussac-Saint-Emillion reposant sur des sols graveleuxx et argilocalcaires',' Robe soutenue','Un bordeaux très complet'])).
