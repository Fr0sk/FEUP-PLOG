restrictLimits(N, _) :- N =< 4.
restrictLimits(N, Vars) :-
    N > 4,
    LastIdx is N-1,
    getRow(0, Vars, N, Top),
    getRow(LastIdx, Vars, N, Bot),
    getCol(0, Vars, N, Left),
    getCol(LastIdx, Vars, N, Right),
    sum(Left,#=,SumL),
    sum(Right,#=,SumR),
    sum(Top,#=,SumT),
    sum(Bot,#=,SumB),
    (SumL#=SumT#/\SumT#=SumR) #\/ (SumT#=SumR#/\SumR#=SumB) #\/ (SumR#=SumB#/\SumB#=SumL) #\/ (SumB#=SumL#/\SumL#=SumT).








restrictLimits(N, Vars) :-
    LastIdx is N-1,
    EdgeSize is 2*N + 2*(N-2),
    getRow(0, Vars, N, Top),
    getRow(LastIdx, Vars, N, Bot),
    getCol(0, Vars, N, LeftTmp),
    getCol(LastIdx, Vars, N, RightTmp),
    removeFstLst(LeftTmp, Left),
    removeFstLst(RightTmp, Right),
    append(Top, Right, Tmp1),
    append(Tmp1, Bot, Tmp2),
    append(Tmp2, Left, Edge).
    /*pattern(Edge, [0,1], 0, EdgeSize, Ptrn1),
    pattern(Edge, [1,0], 0, EdgeSize, Ptrn2).*/

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

pattern(_,_, MaxIdx, MaxIdx, 0).
pattern(List, Pattern, Idx, MaxIdx, N) :-
    Idx < MaxIdx,
    NextIdx is Idx + 1,
    [X0|Xs] = Pattern,
    [X1|_] = Xs,
    nth0(Idx, List, E0),
    nth0(NextIdx, List, E1),
    (E0#=X0 #/\ E1#=X1) #<=> B,
    N #= M+B,
    pattern(List, Pattern, NextIdx, MaxIdx, M).

removeFstLst([_|List], Result) :-
    removeLast(List, Result).

removeLast([], []) :- !, fail.
removeLast([_], []) :- !.
removeLast([X|Xs], [X|Xs2]) :-
    removeLast(Xs, Xs2).








restrictConnection(N, Row, Col, _) :-
    Row is N-1,
    Col is N-1.
restrictConnection(N, Row, Col, Vars) :-
    Row is N-1,
    NextCol is Col+1,
    Idx00 is Row * N + Col,
    Idx01 is Row * N + Col + 1,
    nth0(Idx00, Vars, E00),
    nth0(Idx01, Vars, E01),
    E00#=E01,
    restrictConnection(N, Row, NextCol, Vars).
restrictConnection(N, Row, Col, Vars) :-
    Col is N-1,
    NextRow is Row+1,
    Idx00 is Row * N + Col,
    Idx10 is (Row + 1) * N + Col,
    nth0(Idx00, Vars, E00),
    nth0(Idx10, Vars, E10),
    E00#=E10,
    restrictConnection(N, NextRow, 0, Vars).
restrictConnection(N, Row, Col, Vars) :-
    NextCol is Col+1,
    Idx00 is Row * N + Col,
    Idx01 is Idx00 + 1,
    Idx10 is Idx00+N,
    nth0(Idx00, Vars, E00),
    nth0(Idx01, Vars, E01),
    nth0(Idx10, Vars, E10),
    E00#=E01 #=> E00#=E10,
    restrictConnection(N, Row, NextCol, Vars).








restrictConnection(N, Row, Col, Vars) :-
    /* Bottom right restriction */
    Row is N-1,
    Col is N-1,
    /* Mid-table restriction */
    /* Get cells indexes */
    Idx is Row * N + Col,   /* Current Cell Idx */
    IdxL is Idx - 1,        /* Left Cell Idx */
    IdxT is Idx - N,        /* Top Cell Idx */
    /* Get elements */
    nth0(Idx, Vars, E),     /* Current Cell */
    nth0(IdxL, Vars, EL),   /* Left Cell */
    nth0(IdxT, Vars, ET),   /* Top Cell */
    /* Makes the restriction */
    E#=EL #=> E#=ET.

restrictConnection(N, Row, 0, Vars) :-
    /* Bottom left restriction */
    Row is N-1,
    /* Get cells indexes */
    Idx is Row * N,         /* Current Cell Idx */
    IdxR is Idx + 1,        /* Right Cell Idx */
    IdxT is Idx - N,        /* Top Cell Idx */
    /* Get elements */
    nth0(Idx, Vars, E),     /* Current Cell */
    nth0(IdxR, Vars, ER),   /* Right Cell */
    nth0(IdxT, Vars, ET),   /* Top Cell */
    /* Makes the restriction */
    E#=ER #=> E#=ET,
    /* Next Iteration */
    restrictConnection(N, Row, 1, Vars).

restrictConnection(N, 0, Col, Vars) :-
    /* Top right restriction */
    Col is N-1,
    /* Get cells indexes */
    Idx is Col,             /* Current Cell Idx */
    IdxL is Idx - 1,        /* Left Cell Idx */
    IdxB is Idx + N,        /* Bottom Cell Idx */
    /* Get elements */
    nth0(Idx, Vars, E),     /* Current Cell */
    nth0(IdxL, Vars, EL),   /* Left Cell */
    nth0(IdxB, Vars, EB),   /* Bottom Cell */
    /* Makes the restriction */
    E#=EL #=> E#=EB,
    /* Next Iteration */
    restrictConnection(N, 1, Col, Vars).

restrictConnection(N, 0, 0, Vars) :-
    /* Top left restriction */
    /* Get cells indexes */
    Idx is 0,               /* Current Cell Idx */
    IdxR is Idx + 1,        /* Right Cell Idx */
    IdxB is Idx + N,        /* Bottom Cell Idx */
    /* Get elements */
    nth0(Idx, Vars, E),     /* Current Cell */
    nth0(IdxR, Vars, ER),   /* Right Cell */
    nth0(IdxB, Vars, EB),   /* Bottom Cell */
    /* Makes the restriction */
    E#=ER #=> E#=EB,
    /* Next Iteration */
    restrictConnection(N, 0, 1, Vars).

restrictConnection(N, Row, Col, Vars) :-
    /* Right col restriction */
    Col is N-1,
    /* Get cells indexes */
    Idx is Row * N + Col,   /* Current Cell Idx */
    IdxL is Idx - 1,        /* Left Cell Idx */
    IdxT is Idx - N,        /* Top Cell Idx */
    IdxB is Idx + N,        /* Bottom Cell Idx */
    /* Get elements */
    nth0(Idx, Vars, E),     /* Current Cell */
    nth0(IdxL, Vars, EL),   /* Left Cell */
    nth0(IdxT, Vars, ET),   /* Top Cell */
    nth0(IdxB, Vars, EB),   /* Bottom Cell */
    /* Makes the restriction */
    E#=EL #=> E#=ET #=> E#=EB,
    /* Next Iteration */
    NextRow is Row+1,
    restrictConnection(N, NextRow, Col, Vars).

restrictConnection(N, Row, 0, Vars) :-
    /* Left col restriction */
    /* Get cells indexes */
    Idx is Row * N,   /* Current Cell Idx */
    IdxR is Idx + 1,        /* Right Cell Idx */
    IdxT is Idx - N,        /* Top Cell Idx */
    IdxB is Idx + N,        /* Bottom Cell Idx */
    /* Get elements */
    nth0(Idx, Vars, E),     /* Current Cell */
    nth0(IdxR, Vars, ER),   /* Right Cell */
    nth0(IdxT, Vars, ET),   /* Top Cell */
    nth0(IdxB, Vars, EB),   /* Bottom Cell */
    /* Makes the restriction */
    E#=ER #=> E#=ET #=> E#=EB,
    /* Next Iteration */
    restrictConnection(N, Row, 1, Vars).

restrictConnection(N, 0, Col, Vars) :-
    /* Top row restriction */
    /* Get cells indexes */
    Idx is Col,             /* Current Cell Idx */
    IdxL is Idx - 1,        /* Left Cell Idx */
    IdxR is Idx + 1,        /* Right Cell Idx */
    IdxB is Idx + N,        /* Bottom Cell Idx */
    /* Get elements */
    nth0(Idx, Vars, E),     /* Current Cell */
    nth0(IdxL, Vars, EL),   /* Left Cell */
    nth0(IdxR, Vars, ER),   /* Right Cell */
    nth0(IdxB, Vars, EB),   /* Bottom Cell */
    /* Makes the restriction */
    E#=EL #=> E#=ER #=> E#=EB,
    /* Next Iteration */
    NextCol is Col+1,
    restrictConnection(N, 0, NextCol, Vars).

restrictConnection(N, Row, Col, Vars) :-
    /* Bottom row restriction */
    Row is N-1,
    /* Get cells indexes */
    Idx is Row * N + Col,   /* Current Cell Idx */
    IdxL is Idx - 1,        /* Left Cell Idx */
    IdxR is Idx + 1,        /* Right Cell Idx */
    IdxT is Idx - N,        /* Top Cell Idx */
    /* Get elements */
    nth0(Idx, Vars, E),     /* Current Cell */
    nth0(IdxL, Vars, EL),   /* Left Cell */
    nth0(IdxR, Vars, ER),   /* Right Cell */
    nth0(IdxT, Vars, ET),   /* Top Cell */
    /* Makes the restriction */
    E#=EL #=> E#=ER #=> E#=ET,
    /* Next Iteration */
    NextCol is Col+1,
    restrictConnection(N, Row, NextCol, Vars).

restrictConnection(N, Row, Col, Vars) :-
    /* Mid-table restriction */
    /* Get cells indexes */
    Idx is Row * N + Col,   /* Current Cell Idx */
    IdxL is Idx - 1,        /* Left Cell Idx */
    IdxR is Idx + 1,        /* Right Cell Idx */
    IdxT is Idx - N,        /* Top Cell Idx */
    IdxB is Idx + N,        /* Bottom Cell Idx */
    /* Get elements */
    nth0(Idx, Vars, E),     /* Current Cell */
    nth0(IdxL, Vars, EL),   /* Left Cell */
    nth0(IdxR, Vars, ER),   /* Right Cell */
    nth0(IdxT, Vars, ET),   /* Top Cell */
    nth0(IdxB, Vars, EB),   /* Bottom Cell */
    /* Makes the restriction */
    E#=EL #=> E#=ER #=> E#=ET #=> E#=EB,
    /* Next Iteration */
    NextCol is Col+1,
    restrictConnection(N, Row, NextCol, Vars).