% convience  script  that  allows  for  starting  the  server  from  the
% commandline using
%
%    % swipl app.pl

:- set_prolog_flag(verbose, silent).

:- use_module('./bot/db.prolog',[
    init_vin_db/1
]).

:- use_module('./api/server').



run :- init_vin_db('./bot/db'), start_server.


:- initialization run.
