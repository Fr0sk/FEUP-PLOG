uBreakList([H, T], H, T).

uQuit:- nl, nl, write('Goodbye'), nl, nl, abort.

uSwitchPlayer(Player, NextPlayer):-
    (
        Player==1 -> NextPlayer is 2;
        Player==2 -> NextPlayer is 1
    ).

uTranslateColumn('A', 0).
uTranslateColumn('B', 1).
uTranslateColumn('C', 2).
uTranslateColumn('D', 3).
uTranslateColumn('E', 4).
uTranslateColumn('F', 5).
uTranslateColumn('G', 6).
uTranslateColumn('H', 7).
uTranslateColumn('I', 8).
uTranslateColumn('J', 9).
uTranslateColumn('a', 0).
uTranslateColumn('b', 1).
uTranslateColumn('c', 2).
uTranslateColumn('d', 3).
uTranslateColumn('e', 4).
uTranslateColumn('f', 5).
uTranslateColumn('g', 6).
uTranslateColumn('h', 7).
uTranslateColumn('i', 8).
uTranslateColumn('j', 9).