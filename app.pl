% convience  script  that  allows  for  starting  the  server  from  the
% commandline using
%
%    % swipl run.pl

:- set_prolog_flag(verbose, silent).
:- use_module('api/server').

:- initialization server.
