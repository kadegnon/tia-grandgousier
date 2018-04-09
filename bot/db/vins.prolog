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


assert(vin(les_chaboeufs_2013,'Nuits-Saint-Georges 1er Cru', 2013,'Normandie' ,'bourgogne_rouge','blanc')).
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
assert(prix(les_chaboeufs_2013, 42.35, 45.76)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

