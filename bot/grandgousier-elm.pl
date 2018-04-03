:- use_module(library(lists)).

:- ensure_loaded('./lire_question').
:- ensure_loaded('./ecrire_reponse').
:- ensure_loaded('./produire_reponse').

:- use_module(db, [
    init_vin_db/1
]).

/* --------------------------------------------------------------------- */
/*                                                                       */
/*                         BOUCLE PRINCIPALE                             */
/*                                                                       */
/* --------------------------------------------------------------------- */

grandgousier :- 

   nl, nl, nl,
   write('Bonjour, je suis Grandgousier, GGS pour les intimes,'), nl,
   write('conseiller en vin. En quoi puis-je vous etre utile ?'), 
   nl, nl, 

   repeat,
      write('Vous : '),
      lire_question(L_Mots),
      produire_reponse(L_Mots,L_ligne_reponse),
      ecrire_reponse(L_ligne_reponse),
   fin(L_Mots), !.

fin(L) :- member(fin,L).


grandgousier(Question, L_ligne_reponse) :-
    lire_question(Question, L_Mots),
    produire_reponse(L_Mots,L_ligne_reponse).
   

/* --------------------------------------------------------------------- */
/*                                                                       */
/*             ACTIVATION DU PROGRAMME APRES COMPILATION                 */
/*                                                                       */
/* --------------------------------------------------------------------- */

:- initialization init_vin_db('./db').

# :- grandgousier.

