% convience  script  that  allows  for  starting  the  server  from  the
% commandline using
%
%    % swipl app.pl

:- set_prolog_flag(verbose, silent).
:- use_module('./api/server').

:- initialization server.
