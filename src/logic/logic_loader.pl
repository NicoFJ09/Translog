startLL :-
    write('================================='), nl,
    write('  This is logic loader     '), nl,
    write('  starting              '), nl,
    write('================================='), nl, nl.

% Auto-start when loaded
:- initialization(startLL).