:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-set_prolog_flag(toplevel_print_options, [quoted(true), portrayed(true), max_depth(0)]).
:-['DisplayBoard', 'Boards', 'Utils'].

rotatelist([H|T], R) :- append(T, [H], R).

test(N):-
    /*List = [0, 1, 1, 1, 0],*/
    /*List = [X0,X1,X2,X3,X4,X5],*/
    NxN #= N*N,
    makeVarList(NxN, List),
    domain(List, 0, 1),

    
    restrictLimits(N, List),

    restrict2X2(N, List),

    restrictMiddle(N, List),

    labeling([down], List),
    restrictMiddlePiece(N, List),
    displayBoard(N, List).



restrictIslandCol(N, _, _, Size) :-
    N#>3, 
    Size#=N-1.
restrictIslandCol(N, Vars, Idx, Size) :-
    N#>3, 
    Size#>1,
    Size#<N-1,
    Idx+Size#=N,
    NextSize#=Size+1,
    restrictIslandCol(N, Vars, 0, NextSize).
restrictIslandCol(N, Vars, Idx, Size) :-
    N#>3, 
    Size#>1,
    Size#<N-1,
    Idx+Size#<N.
    
    /*Idx #> 0,
    Idx #< N-1,
    PrevIdx #= Idx-1,
    NextIdx #= Idx+1,
    LastIdx #= N-1,

    getCol(Idx, Vars, N, Col),
    getCol(PrevIdx, Vars, N, LeftColTmp),
    getCol(NextIdx, Vars, N, RightColTmp),

    removeFstLst(Col, MidCol),
    removeFstLst(LeftColTmp, LeftCol),
    removeFstLst(RightColTmp, RightCol),

    nth0(0, Col, FirstElem),
    nth0(LastIdx, Col, LastElem),*/

yinyang(N) :-
    NxN #= N*N,
    makeVarList(NxN, List),
    domain(List, 0, 1),
    restrictLimits(N, List),
    restrict2X2(N, List),
    restrictMiddle(N, List),
    labeling([down], List),
    restrictMiddlePiece(N, List),
    displayBoard(N, List).

makeVarList(0, []).
makeVarList(N, [_|More]) :-
    N>0,
    Next is N-1,
    makeVarList(Next, More).

/* A 2x2 can't all the same value */
restrict2X2(N, Vars) :-
    restrict2X2(N, 0, 0, Vars).
restrict2X2(N, Row, _, _) :-
    Row is N-1.
restrict2X2(N, Row, Col, Vars) :-
    Col is N-1,
    NextRow is Row+1,
    restrict2X2(N, NextRow, 0, Vars).
restrict2X2(N, Row, Col, Vars) :-
    NextCol is Col+1,
    get2X2Group(N, Row, Col, Vars, Group),
    sum(Group, #\=, 0),
    sum(Group, #\=, 4),
    restrictDiagonals(Group),
    restrict2X2(N, Row, NextCol, Vars).

/* A 2x2 can't be [10 01] neither [01 10] */
restrictDiagonals(Group) :-
    nth0(0, Group, E0),
    nth0(1, Group, E1),
    nth0(2, Group, E2),
    nth0(3, Group, E3),
    E0#=E3 #=> A,
    E1#=E2 #=> B,
    C #= A+B,
    C#<2.

/* No middle row/col can be all the same value */
restrictMiddle(N, Vars) :-
    restrictMiddle(N, Vars, 1).
restrictMiddle(N, Vars, Idx) :-
    Idx #> 0,
    Idx #< N-1,
    NextIdx is Idx+1,
    getRow(Idx, Vars, N, Row),
    getCol(Idx, Vars, N, Col),
    sum(Row, #>, 0),
    sum(Row, #<, N),
    sum(Col, #>, 0),
    sum(Col, #<, N),
    restrictMiddle(N, Vars, NextIdx).
restrictMiddle(N, _, Idx) :- Idx#=N-1.

/* No middle piece can be surrounded by others with other values */
restrictMiddlePiece(N, Vars) :-
    restrictMiddlePiece(N, Vars, 1, 1).
restrictMiddlePiece(N, _, Row, _) :-
    Row #= N-1.
restrictMiddlePiece(N, Vars, Row, Col) :-
    Col #= N-1,
    NextRow #= Row+1,
    restrictMiddlePiece(N, Vars, NextRow, 1).
restrictMiddlePiece(N, Vars, Row, Col) :-
    Row #> 0,
    Row #< N-1,
    Col #> 0,
    Col #< N-1,
    NextCol #= Col+1,
    Idx #= Row*N+Col,
    IdxT #= Idx-N,
    IdxR #= Idx+1,
    IdxB #= Idx+N,
    IdxL #= Idx-1,
    nth0(Idx, Vars, E),
    nth0(IdxT, Vars, ET),
    nth0(IdxR, Vars, ER),
    nth0(IdxB, Vars, EB),
    nth0(IdxL, Vars, EL),
    E#=ET #<=> A,
    E#=ER #<=> B,
    E#=EB #<=> C,
    E#=EL #<=> D,
    X#=A+B+C+D,
    X#>0,
    restrictMiddlePiece(N, Vars, Row, NextCol).

/* Edge restrictions */
restrictLimits(N, Vars) :-
    getEdge(N, Vars, Edge),
    restrictLimits(Edge).
restrictLimits([X|Xs]) :-
    N#=<2,
    restrictLimits(X, Xs, N).
restrictLimits(_, [], 0).
restrictLimits(Previous, [X|Xs], Switches) :-
    Previous #\= X #<=> Switched,
    Switches #= Switched + AccumulateSwitches,
    restrictLimits(X,Xs,AccumulateSwitches).