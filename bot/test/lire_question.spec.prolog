
% :- include('./_lib/crisp_includes').

:- use_module('../lire_question',[
    lire_question/2
]).

/*****************************************************************************/
% lire_question(+Question, -ListOfAtoms).
%
% True if ListOfAtoms is 
% e.g. "This is an example !"  ==> [this,is,an,example].

describe(lire_question/2, [
    lire_question("a",[a]),
    fail-lire_question("Abc",['Abc']),
    lire_question("ABC",[abc]),
    lire_question("test",[test]),
    fail-lire_question("This is , an example !", [this,is,an, ',',example, '!']),
    lire_question("This is an example !",[this,is,an,example])
]).
