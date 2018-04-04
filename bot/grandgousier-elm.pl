:- module(ggs,[
    intro/1,
    grandgousier/2,
    grandgousier/0
    
]).

:- use_module(library(lists)).

:- ensure_loaded('./lire_question').
:- ensure_loaded('./ecrire_reponse').
:- ensure_loaded('./produire_reponse').




intro([
    'Bonjour, je suis Grandgousier, GGS pour les intimes, conseiller en vin. ', 
    'En quoi, puis-je vous etre utile ?'
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


grandgousier(Question, Ligne_reponse) :-
    lire_question(Question, L_Mots),  
    produire_reponse(L_Mots, M_ligne_reponse),
    flatten_reponse(M_ligne_reponse, Ligne_reponse).
   
flatten_reponse([], []).
flatten_reponse([As|T], [String | FlatR]) :-
    atomics_to_string(As, " ", String),
    flatten_reponse(T, FlatR).

    
/* --------------------------------------------------------------------- */
/*                                                                       */
/*             ACTIVATION DU PROGRAMME APRES COMPILATION                 */
/*                                                                       */
/* --------------------------------------------------------------------- */

% :- grandgousier.

