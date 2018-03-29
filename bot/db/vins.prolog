%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% vin(Id,Nom,millesime,Origine,Appellation,Couleur).
%% prix(VinId,Prix).
%% bouche(VinId,Text).
%% nez(VinId,Atom_Text).
%% description(VinId,Text).
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


assert(vin(les_chaboeufs_2013,'Nuits-Saint-Georges 1er Cru', 2013, 'Normandie','Les Chaboeufs','Blanc')).
assert(vin(beaumes_de_venise_2015,'Beaumes-de-Venise', 2015,'Venise','Bordeaux','Rosé')).
assert(prix(beaumes_de_venise_2015, 12.34, 87.45)).
assert(nez(beaumes_de_venise_2015,[intensement, parfume])).
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


assert(prix(les_chaboeufs_2013, 42.35, 45.76)).

