uBreakList([H, T], H, T).

uQuit:- nl, nl, write('Goodbye'), nl, nl, abort.

uSwitchPlayer(Player, NextPlayer):-
    (
        Player==1 -> NextPlayer is 2;
        Player==2 -> NextPlayer is 1
    ).
    