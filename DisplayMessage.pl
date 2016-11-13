dmShowHeader :-
    nl, nl,
    write('***************************************'),nl,
    write('****************  ORDO  ***************'),nl,
    write('***************************************'),nl,
    nl, nl.

dmShowMainMenu :- 
    write('1. Start Game'),nl,
    write('2. View game rules'),nl,
    write('3. Quit game'),nl, nl, imMenu.

dmShowRules:-
    nl, nl,
    write('To view the full game rules navigate to: '), nl,
    write('https://spielstein.com/games/ordo/rules/official'), nl,
    write('Write "menu." to go to the main menu'), nl, nl.

dmShowPlayInfo(Board, PlayerName, Piece) :-
    nl, nl, dbDrawBoard(Board), nl, nl,
    write(PlayerName), 
    write(' ('), 
    write(Piece),
    write('), it\'s your turn!'), nl,
    dmShowMoveCommands, nl.

dmShowMoveCommands :-
    write('1. Move a single piece.'), nl,
    write('2. Move a horizontal ordo.'), nl,
    write('3. Move a vertical ordo.'), nl, 
    write('0. Quit').

/*dmShowMoveCommands :-
    write('1. movePiece(Xi, Yi, Xf, Yf)." to move a single piece.'), nl,
    write('Use "moveHorzOrdo(XiLeft, XiRight, Yi, Yf)." to move a horizontal ordo.'), nl,
    write('Use "moveVertOrdo(Xi, YiTop, YiBot, Xf)." to move a vertical ordo.'), nl.*/