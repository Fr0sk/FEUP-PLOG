imMenu :-
    read(Opt),
    (   
        Opt==1 -> play;
        Opt==2 -> dmShowRules, dmShowMainMenu;
        Opt==3 -> uQuit
    ). 

imSelectPlay :-
    read(Opt),
    (
        Opt==1 -> imPlaySinglePiece;
        Opt==2 -> imPlayHorzOrdo;
        Opt==3 -> imPlayVertOrdo;
        Opt==0 -> uQuit
    ).

imPlaySinglePiece :-
    write('Play Single').

imPlayHorzOrdo :-
    write('Play Horz').

imPlayVertOrdo :-
    write('Play Vert').