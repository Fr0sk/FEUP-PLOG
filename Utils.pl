uBreakList([H, T], H, T).

uQuit:- nl, nl, write('Goodbye'), nl, nl, abort.

uSwitchPlayer(Player, NextPlayer):-
    (
        Player==1 -> NextPlayer is 2;
        Player==2 -> NextPlayer is 1
    ).

uChangeElem([_|Xs], 0, Elem, [Elem|Xs]).
uChangeElem([X|Xs], Index, Elem, [X|Ys]):-
    NextIndex is Index - 1,
    uChangeElem(Xs, NextIndex, Elem, Ys).

uChangeElem([X|Xs], ColumnIndex, 0, Elem, [Y|Xs]) :-
    uChangeElem(X, ColumnIndex, Elem, Y).
uChangeElem([X|Xs], ColumnIndex, RowIndex, Elem, [X|Ys]) :-
    NextIndex is RowIndex - 1,
    uChangeElem(Xs, ColumnIndex, NextIndex, Elem, Ys).


uGetIndexElem([X|_], 0, X).
uGetIndexElem([_|Xs], Index, Elem):-
   NewIndex is Index - 1,
   uGetIndexElem(Xs, NewIndex, Elem).

uGetIndexElem(Array2D, ColumnIndex, RowIndex, Elem) :-
    CIndex is ColumnIndex,
    RIndex is RowIndex,
    uGetIndexElem(Array2D, RIndex, Row),
    uGetIndexElem(Row, CIndex, Result),
    %write('ELEM'), write(Row), nl,
    (
        Result == 0 -> Elem = 0,!;
        Result == 1 -> Elem = 1,!;
        Result == 2 -> Elem = 2,!
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