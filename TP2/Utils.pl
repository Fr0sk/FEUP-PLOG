get2X2Group(N, Row, Col, Vars, Group) :-
    Idx00 is Row * N + Col,
    Idx01 is Row * N + Col + 1,
    Idx10 is (Row + 1) * N + Col,
    Idx11 is (Row + 1) * N + Col + 1,
    nth0(Idx00, Vars, E00),
    nth0(Idx01, Vars, E01),
    nth0(Idx10, Vars, E10),
    nth0(Idx11, Vars, E11),
    Group = [E00, E01, E10, E11].

getEdge(N, Vars, Edge) :-
    LastIdx is N-1,
    getRow(0, Vars, N, Top),
    getRow(LastIdx, Vars, N, BotRev),
    getCol(0, Vars, N, LeftTmp),
    getCol(LastIdx, Vars, N, RightTmp),
    removeFstLst(RightTmp, Right),
    removeFstLst(LeftTmp, LeftRev),
    reverse(LeftRev, Left),
    reverse(BotRev, Bot),
    append(Top, Right, Tmp1),
    append(Tmp1, Bot, Tmp2),
    append(Tmp2, Left, Edge).

getCol(Col, Tab, N, List) :-
    collectColumn(Col, N, Tab, List).
collectColumn(Idx, N, _, []) :-
    NxN is N*N,
    Idx >= NxN.
collectColumn(Idx, N, Tab, [Var|More]) :-
    NxN is N*N,
    Idx < NxN,
    nth0(Idx, Tab, Var),
    Next is Idx + N,
    collectColumn(Next, N, Tab, More).

getRow(Row, Tab, N, List) :-
    RowIdx is Row*N,
    LastIdx is RowIdx + N - 1,
    collectRow(RowIdx, LastIdx, Tab, List).
collectRow(Idx, LastIdx, _, []) :-
    Idx > LastIdx.
collectRow(Idx, LastIdx, Tab, [Var|More]) :-
    Idx =< LastIdx,
    nth0(Idx, Tab, Var),
    Next is Idx + 1,
    collectRow(Next, LastIdx, Tab, More).

removeFstLst([_|List], Result) :-
    removeLast(List, Result).

removeLast([], []) :- !, fail.
removeLast([_], []) :- !.
removeLast([X|Xs], [X|Xs2]) :-
    removeLast(Xs, Xs2).

sublst(List, Idx, Size, Sublist) :-
    sublst(List, Idx, 0, Size, Sublist).
sublst(_, _, Size, Size, []) :-
sublst(List, Idx, Cnt, Size, [X|Xs]) :-
    NextIdx #= Idx+1,
    NextCnt #= Cnt+1,
    nth0(Idx, List, X),
    sublst(List, NextIdx, NextCnt, Size, Xs).