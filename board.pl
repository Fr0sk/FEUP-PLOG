sample0 :-
    nl,initialize(X),drawBoard(X).
sample1 :-
    X = [[0,0,1,1,0,0,0,0,0,0], 
         [0,1,1,1,0,0,0,0,0,2], 
         [1,0,1,0,1,1,0,2,2,0], 
         [1,1,1,1,1,0,0,2,0,0], 
         [0,1,0,0,0,2,0,2,0,0], 
         [0,0,0,2,2,2,2,2,0,0], 
         [0,0,2,2,2,2,0,0,0,0], 
         [0,0,0,0,0,0,0,0,0,0]],
    nl,drawBoard(X).
sample2 :-
    X = [[0,0,0,0,0,0,0,0,0,0], 
         [0,0,0,0,0,0,0,0,0,0], 
         [1,0,0,0,1,1,0,2,2,0], 
         [1,1,0,1,1,0,0,0,0,0], 
         [0,1,1,1,0,2,0,2,0,0], 
         [0,1,0,2,2,2,2,2,0,0], 
         [1,1,2,2,2,2,0,0,0,0], 
         [1,0,0,0,2,2,2,2,0,0]],
    nl,drawBoard(X).
sample3 :-
    X = [[0,0,0,0,0,0,0,0,0,0], 
         [0,0,0,0,0,0,0,0,0,0],  
         [0,0,0,0,0,0,0,0,0,0], 
         [0,0,0,0,0,0,0,0,0,0], 
         [0,0,0,0,0,0,0,0,0,0], 
         [0,0,0,0,0,0,0,0,0,0], 
         [0,0,0,0,0,0,0,0,0,0],  
         [0,0,0,0,0,0,0,0,0,0]],
    nl,drawBoard(X).

initialize(Board) :-
    Board = [[0,0,1,1,0,0,1,1,0,0],
            [1,1,1,1,1,1,1,1,1,1], 
            [1,1,0,0,1,1,0,0,1,1], 
            [0,0,0,0,0,0,0,0,0,0], 
            [0,0,0,0,0,0,0,0,0,0], 
            [2,2,0,0,2,2,0,0,2,2], 
            [2,2,2,2,2,2,2,2,2,2], 
            [0,0,2,2,0,0,2,2,0,0]].

drawBoard(Board) :-
    write('  A   B   C   D   E   F   G   H   I   J'),nl,
	drawLine(Board, 1).

drawLine([X|Xs], Row) :-
    drawHLine,nl,
    drawCell(X),
    write(' '),
    write(Row),
    NextRow is Row + 1,
    nl,
    drawLine(Xs, NextRow).

drawLine([], Row) :-
    drawHLine.

drawHLine :-
    write('+---+---+---+---+---+---+---+---+---+---+').

drawCell([X|Xs]) :-
    write('|'), 
    X==0 -> write('   '), drawCell(Xs);
    X==1 -> write(' P '), drawCell(Xs);
    X==2 -> write(' B '), drawCell(Xs).

drawCell([]) :-
    write('|').