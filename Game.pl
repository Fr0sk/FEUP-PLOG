:-['Boards', 'DisplayBoard', 'DisplayMessage', 'InputManager', 'PlaysList', 'Rules', 'Utils'].

start :-
    dmShowHeader,
    dmShowMainMenu.

/* Game flow predicates */

play :-
    initialize(Board),
    write('Enter Player 1 name (lowercase): '),
    read(Player1), nl,
    write('Enter Player 2 name (lowercase): '),
    read(Player2), nl,
    Player is 1,
    play(Board, Player, Player1, Player2).

play(Board, Player, Player1, Player2):-
    (
        Player==1 -> dmShowPlayInfo(Board, Player1, 'P');
        Player==2 -> dmShowPlayInfo(Board, Player2, 'B')
    ),
    imSelectPlay,
    uSwitchPlayer(Player, NextPlayer),
    play(Board, NextPlayer, Player1, Player2).
/* END Game flow predicates */

