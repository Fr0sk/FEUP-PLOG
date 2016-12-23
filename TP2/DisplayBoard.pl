displayBoard(N, Vars) :-
    displayRow(N, N, Vars).

displayRow(RowSize, 0, _) :-
    displayHeader(RowSize).
displayRow(RowSize, Rows, Vars) :-
    Index is (RowSize - Rows) * RowSize,
    displayHeader(RowSize),
    displayRowContent(RowSize, Index, Vars),
    Next is Rows-1,
    displayRow(RowSize, Next, Vars).
    
displayHeader(0) :-
    write('+'), nl.
displayHeader(N) :-
    Next is N-1,
    write('+-'),
    displayHeader(Next).

displayRowContent(0, _, _) :-
    write('|'), nl.
displayRowContent(Count, Index, Vars) :-
    Next is Count-1,
    NextIdx is Index + 1,
    nth0(Index, Vars, Elem),
    displayCell(Elem),
    displayRowContent(Next, NextIdx, Vars).

displayCell(1) :-
    write('|*').
displayCell(_) :-
    write('| ').