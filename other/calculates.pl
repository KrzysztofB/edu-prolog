%%num(X) :- number(X).

calculates(_, num(N), num(N)).

calculates(Tab, plus(E1, E2), num(R)) :-
  calculates(Tab, E1, num(N1)),
  calculates(Tab, E2, num(N2)),
  R is N1 + N2.

%% calculates([],plus(num(2),num(3)),R)

