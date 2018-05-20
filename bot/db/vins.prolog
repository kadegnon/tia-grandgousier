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

assert(vin(les_chaboeufs_2013,'Nuits—Saint-Georges 1er Cru \'Les Chaboeufs\'', 2013, 'normandie' ,'bourgogne','blanc')).
assert(prix(les_chaboeufs_2013, 35, 42.35)).
assert(nez(les_chaboeufs_2013,[intensement, 'élégant'])).
assert(bouche(les_chaboeufs_2013,['belle epaisseur', 'puissant', 'riche', 'rond', 'genereux', 'longueur superbe'])).
assert(description(les_chaboeufs_2013,[ 
  'Sur une parcelle escarpée, pierreuse',
  'Belle intensité aromatique ou se mêlent, avec élégance, les notes de griotte, de sous-bois (feuilles mortes) et de champignon'
])).

assert(vin(fleur_pomys_2012,'La Fleur de Pomys', 2012, 'Sainte-Estephe','bordeaux_rouge','rouge')).
assert(prix(fleur_pomys_2012, 17.65, 21.36)).
assert(nez(fleur_pomys_2012,[empyreumatique, annonce, un, vin,complexe,et, 'concentre'])).
assert(bouche(fleur_pomys_2012,
  [  'les aromes de myrtille et de cassis se melent a des notes glorales et a un boise bien integre',
     'Les saveurs sont riches et concentrees, avec beaucoup de densite' ,
     'la finale laisse le souvenir d\' un Saint-Estephe a la fois complet, dense et race.'
  ])).
assert(accompagne(fleur_pomys_2012,[viandes_rouges_grillées,carré_dagneau,entrecôte_grillée])).
assert(description(fleur_pomys_2012,[ 
  'Propriete du Nord du Haut-Medoc reposant aur le terroir argillo-graveleux a l\'origine de vins plus charpentes',
  'La robe est profonde'
])).


assert(vin(chambolle_musigy_2012,'Chambolle-Musigny', 2012, 'Les Noirots','vallee_du_rhone_et_languedoc','rouge')).
assert(prix(chambolle_musigy_2012, 52.77, 63.85)).
assert(nez(chambolle_musigy_2012,[complexe,intense,de,fruits,rouges,'d\'epices (notes de poivres)',meles,a,des,nuances,empyreumatiques,et,de,'sous-bois'])).
assert(accompagne(chambolle_musigy_2012,[coq_au_vin,croûtes_fleuries_camembert_brie])).
assert(bouche(chambolle_musigy_2012,  ['Complexe avec des saveurs denses, concentrees et enrobees'])).
assert(description(chambolle_musigy_2012,['Grand vin opulent, puissant, race et long'])).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


assert(vin(b477d59c,'Ch. Moulin de Mallet',2014,'dordogne',bordeaux_rouge,'rouge')).
assert(prix(b477d59c,5.66,6.848)).
assert(bouche(b477d59c,['Jolie robe grenat aux reflets rubis'])).
assert(nez(b477d59c,[tendrement,parfumé,tendre])).
assert(pour(b477d59c,[])).
assert(accompagne(b477d59c,[filet_américain])).
assert(description(b477d59c,['Un jolie vin, classique, polyvalent, avec un bel éventail aromatique et des tannins fins',' Très bel équilibre de l\'ensemble, et un boisé bien intégré'])).

assert(vin('4c23dabc','Ch. La Fleur Baudron',2014,'Lussac-Saint-Emilion',bordeaux_rouge,'')).
assert(prix('4c23dabc',6.18,7.47)).
assert(bouche('4c23dabc',['Très plaisant, riche, et de beaux tanins associés à un boisé bien intégré','Un bordeaux très complet'])).
assert(nez('4c23dabc',['aromes de fruits compots','epices fines','nuance florale (violette)'])).
assert(pour('4c23dabc',[])).
assert(accompagne('4c23dabc',[confit_oie_ou_canard])).
assert(description('4c23dabc',['Magnifique terroir à l\'arrière de Lussac-Saint-Emillion reposant sur des sols graveleuxx et argilocalcaires',' Robe soutenue','Un bordeaux très complet'])).

assert(vin('dcc91cbe','Coteaux Bourguignons',2014,'bourgogne','bourgogne','rouge')).
assert(prix('dcc91cbe',6.6,7.99)).
assert(bouche('dcc91cbe',['intensité de fruit se prolonge','avec des saveurs juteuses', 'L\'ensemble est très plaisant, dans un style gouleyant, rond et léger.'])).
assert(nez('dcc91cbe',['arômes de cerise','associés','a des nuances florales (Violette)s','et minérales'])).
assert(pour('dcc91cbe',[])).
assert(accompagne('dcc91cbe',[])).
assert(description('dcc91cbe',['Dès la mise au nez on est sous le charme, avec des arômes de cerise associés a des nuances florales (Violette) et minérales.','Cette intensité de fruit se prolonge en bouche avec des saveurs juteuses', 'L\'ensemble est très plaisant, dans un style gouleyant, rond et léger.'])).

assert(vin('ecba35ea','Bourgogne Pinot Noir - Cuvée les Mames',2014,'Pays d\'Oc','bourgogne','rouge')).
assert(prix('ecba35ea',9.85, 11.92)).
assert(bouche('ecba35ea',['fin et concentré','avec des saveurs d\'une grande unité', 'généreux' , 'frais', 'tendre', 'gourmand', 'Beaucoup de plénitude'])).
assert(nez('ecba35ea',['Parfumée','arômes de griottes et de fruits des bois','associés','à de iolies notes épicées'])).
assert(pour('ecba35ea',[])).
assert(accompagne('ecba35ea',[])).
assert(description('ecba35ea',['Cuvée issue de vignes de la Côte de Nuits.','Parfumée avec des arômes de griottes et de fruits des bois associés à de iolies notes épicées.', 'Un Bourgogne à la fois fin et concentré. avec des saveurs
d\'une grande unité.', 'L\'ensemble est généreux, frais, tendre et gourmand. Beaucoup de plénitude. Tres polyvalent.'])).

assert(vin('4db490c4','Hautes Côtes de Nuits',2014,'Côte-de-Nuits','bourgogne','rouge')).
assert(prix('4db490c4',12.53, 15.16)).
assert(bouche('4db490c4',['joli grain','d\'une texture souple', 'bien enrobée'])).
assert(nez('4db490c4',['bien expressif','typé fruits rouges (groseilles, griottes)','nuances florales'])).
assert(pour('4db490c4',[])).
assert(accompagne('4db490c4',[])).
assert(description('4db490c4',['Le Vignoble des Hautes Côtes se situe sur le plateau entre 300 m et 400 m d\'altitude sur les hauteurs de la Côte de Nuits.','Belle robe brillante', 'Toute l\'harmonie, le charme du Pinot Noir sur un joli terroir qui lui apporte finesse et personnalité.'])).

assert(vin('4e0e9c2c','Hermitage rouge',2007,'Côte-de-Nuits','vallee_du_rhone_et_languedoc','rouge')).
assert(prix('4e0e9c2c',28.08, 33.98)).
assert(bouche('4e0e9c2c',['grande harmonie','très homogène','avec une belle profondeur','aucune dureté'])).
assert(nez('4e0e9c2c',['bouquet complexe','très profond','associant les fruits noirs','les agrumes','à des notes de tabac et de réglisse'])).
assert(pour('4e0e9c2c',[])).
assert(accompagne('4e0e9c2c',[confit_oie_ou_canard, agneau, gigot_dagneau,boeuf_grillé,tournedos_rossini,gibier_à_poils,cassoulet])).
assert(description('4e0e9c2c',['C\'est un vin de grande allure, racé, qui s\'épanouit superbement.', 'Une complexité qui témoigne d\'un grand vin'])).

assert(vin('51149926','Champagne Brut Réserve',2018,'j. vesselle à bouzy','champagne','mousseux')).
assert(prix('51149926',19.12, 23.14)).
assert(bouche('51149926',[])).
assert(nez('51149926',['fruités','raffinés'])).
assert(pour('51149926',[aperitif])).
assert(accompagne('51149926',[tartes_aux_fruits])).
assert(description('51149926',['Cuvée de tradition, harmonieuse, souple et délicate à toute heure.','Champagne de cérémonies et de desserts.'])).

assert(vin('53c3c9f8','Champagne extra Brut',2018,'j. vesselle à bouzy','champagne','mousseux')).
assert(prix('53c3c9f8',20.06, 24.17)).
assert(bouche('53c3c9f8',[superbe, finesse])).
assert(nez('53c3c9f8',[superbe, finesse])).
assert(pour('53c3c9f8',[aperitif])).
assert(accompagne('53c3c9f8',[carpaccio_de_poisson,crustacés,fruits_de_mer])).
assert(description('53c3c9f8',['La vérité, la ﬁnesse et l\'élégance à l\'état pur','Champagne très digeste, non dosé, brut 100%', 'Composé en grande majorité de pinot noir (80%)', 'L\'assemblage est complété par 20% de chardonnay', 'Champagne d\'apéritif par excellence'])).

assert(vin('53c3c9f8','Champagne extra Brut',2018,'j. vesselle à bouzy','champagne','mousseux')).
assert(prix('53c3c9f8',20.06, 24.17)).
assert(bouche('53c3c9f8',[superbe, finesse])).
assert(nez('53c3c9f8',[superbe, finesse])).
assert(pour('53c3c9f8',[aperitif])).
assert(accompagne('53c3c9f8',[carpaccio_de_poisson,crustacés,fruits_de_mer])).
assert(description('53c3c9f8',['La vérité, la ﬁnesse et l\'élégance à l\'état pur','Champagne très digeste, non dosé, brut 100%', 'Composé en grande majorité de pinot noir (80%)', 'L\'assemblage est complété par 20% de chardonnay', 'Champagne d\'apéritif par excellence'])).

assert(vin('2638f900','Champagne Brut Œil de Perdrix',2018,'j. vesselle à bouzy','champagne','mousseux')).
assert(prix('2638f900',20.22, 24.47)).
assert(bouche('2638f900',['grande intensité aromatique', rare, 'loin des grandes séries'])).
assert(nez('2638f900',['issu de raisins surmaturés', 'teinte ambrée'])).
assert(pour('2638f900',[desserts])).
assert(accompagne('2638f900',[poisson_au_four,homar,cochon_de_lait,desserts_aux_fruits_rouges])).
assert(description('2638f900',['La vérité, la ﬁnesse et l\'élégance à l\'état pur','Champagne très digeste, non dosé, brut 100%', 'Composé en grande majorité de pinot noir (80%)', 'L\'assemblage est complété par 20% de chardonnay', 'Champagne d\'apéritif par excellence'])).

assert(vin('f8b30078','Madiran Vieilles Vignes',2006,'j. vesselle à bouzy','bordeaux_rouge','rouge')).
assert(prix('f8b30078',8.20, 9.92)).
assert(bouche('f8b30078',['puissant', 'charpenté', 'austère'])).
assert(nez('f8b30078',['avec des notes de fruits noirs', 'et une touche typique de cacao'])).
assert(pour('f8b30078',[préparations_asiatiques, viandes_rouges])).
assert(accompagne('f8b30078',[confit_oie_ou_canard,gibier_à_poils,cassoulet,plat_asiatique_viande_épicé_curry_piment_gingembre])).
assert(description('f8b30078',['Le cépage tannat annonce la couleur : un vin charpenté, riche en tannins','Oui, mais avec du gras', 'Nous vous le recommandons en accompagnement de préparations fortes en goût'])).

assert(vin('2fe4f328','Mâcon-Villages',2015,'Bourgogne','bourgogne','blanc')).
assert(prix('2fe4f328',8.75, 10.59)).
assert(bouche('2fe4f328',[harmonie, ampleur, race, 'élégance', 'équilibré'])).
assert(nez('2fe4f328',['sous le charme des fruits (pomme, coing)', 'avec des notes de beurre et de miel'])).
assert(pour('2fe4f328',[entrée, préparations_asiatiques, poisson, fruits_de_mer_et_crustacés])).
assert(accompagne('2fe4f328',[entrée_chaude,calamars,escargots,saumon_fumé,scampis,fruits_de_mer,crustacés,poissons_grillés_thon_espadon,poissons_pochés, poissons_en_sauce_crémeuse_ou_épicée,poisson_au_four,bar, thon,turbot,rouget, blanquette_de_veau, paella, croquette_de_crevette, tomate_crevète, poisson_crustacé_prépa_aigre_douce_asiatique, assortiment_vapeur_dim_sum])).
assert(description('2fe4f328',['Magniﬁque expression du cépage Chardonnay sur un terroir de Bourgogne','Un Bourgogne blanc comme on les aime ! Délicieux'])).
