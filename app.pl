% convience  script  that  allows  for  starting  the  server  from  the
% commandline using
%
%    % swipl -s app.pl -g api

:- set_prolog_flag(verbose, silent).

:- use_module('./bot/db.prolog',[
    init_vin_db/1
]).


:- use_module('./api/server').

:- use_module('./bot/grandgousier-elm').


:- initialization init_vin_db('./bot/db').


ggs	:- grandgousier.

api :- start_server.



%% By default, exec ggs

% :- ggs.


