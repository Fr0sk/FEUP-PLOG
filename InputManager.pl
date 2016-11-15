imMenu :-
    read(Opt),
    (   
        Opt==1 -> play;
        Opt==2 -> dmShowRules, dmShowMainMenu;
        Opt==3 -> uQuit;
        dmInvalidMove, fail
    ). 

imSelectPlay :-
    nl, nl, read(Opt), nl, nl,
    (
        Opt==1 -> imPlaySinglePiece;
        Opt==2 -> imPlayHorzOrdo;
        Opt==3 -> imPlayVertOrdo;
        Opt==0 -> uQuit;
        dmInvalidMove, fail
    ).

imPlaySinglePiece :-
    dmShowMoveSinglePiece.

imPlayHorzOrdo :-
    write('Not yet implemented!'), nl, fail.

imPlayVertOrdo :-
    write('Not yet implemented!'), nl, fail.