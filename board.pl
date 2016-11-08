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

start :-
    menu.

menu :-
    nl, nl,
    write('***************************************'),nl,
    write('****************  ORDO  ***************'),nl,
    write('***************************************'),nl,
    nl, nl,
    write('Write "play." to start the game'),nl,
    write('Write "rules." to view the game rules'),nl, nl.


/* Game flow predicates */

play :- 
    initialize(Board),
    Player is 1,
    play(Board, Player).
    
play(Board, 1) :-
    drawBoard(Board), nl, nl,
    write('Player 1 (P), it\'s your turn!'), nl,
    showMoveCommands.

play(Board, 2) :-
    drawBoard(Board), nl, nl,
    write('Player 2 (B), it\'s your turn!'), nl, 
    showMoveCommands.


/* Movement predicates */

movePiece(Xi, Yi, Xf, Yf) :-
    write('Moving piece').


/* Board drawing predicates */

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


/* Information predicates */

rules :-
    nl, nl,
    write('To view the full game rules navigate to: '), nl,
    write('https://spielstein.com/games/ordo/rules/official'), nl,
    write('Write "menu." to go to the main menu'), nl, nl.

showMoveCommands :-
    write('Use "movePiece(Xi, Yi, Xf, Yf)." to move a single piece.'), nl,
    write('Use "moveHorzOrdo(XiLeft, XiRight, Yi, Yf)." to move a horizontal ordo.'), nl,
    write('Use "moveVertOrdo(Xi, YiTop, YiBot, Xf)." to move a vertical ordo.'), nl.

