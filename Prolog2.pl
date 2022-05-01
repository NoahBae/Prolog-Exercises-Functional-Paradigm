unifiable([], _, []).
unifiable([X|L1], Term, L2) :-
\+ X = Term,
unifibale(L1, Term, L2).
unifiable([X|L1], Term, [X|L2]) :-
unifiable(L1, Term, L2).