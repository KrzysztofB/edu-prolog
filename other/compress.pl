
%compress(List, Result).
% List = [a,a,a,a,b,b,c,d,d]
% Result = [ [a,4], [b,2], [c,1], [d,2] ]
compress([], []).
compress(List, Result) :-
    maplist(expand, List, Expanded),
    reduce(Expanded, Result).

expand(X, [X,1]).

reduce([],[]).
reduce([[X,N1] , [X,N2] | Tail], Result):-
    !, N3 is N1 + N2,
    reduce([ [X,N3] | Tail ], Result).
reduce([ [X,N1], [Y,N2] | Tail], [[X,N1] | Result]):-
    !, reduce([ [Y,N2] | Tail], Result).
reduce(X,X).
