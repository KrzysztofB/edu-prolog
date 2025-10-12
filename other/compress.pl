
%compress(List, Result).
% List = [a,a,a,a,b,b,c,d,d]
% Result = [ [a,4], [b,2], [c,1], [d,2] ]
% one way, simple function,compression only
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


%compress2(List, Result).
%trying to make it Prolog way (more unifications),still one way function
% List = [a,a,a,a,b,b,c,d,d]
% Result = [ [a,4], [b,2], [c,1], [d,2] ]
compress2([], []).
compress2([Item|Tail], [[Item, Count]|MoreCompressed]) :-
    compress_same_items([Item|Tail], [Item, Count], MoreToCompress),
    compress2(MoreToCompress, MoreCompressed).

compress_same_items([Item], [Item, 1],[]).
compress_same_items([Item|More], [Item, CountPlus1], Rest) :-
    compress_same_items(More, [Item, Count], Rest),
    succ(Count,CountPlus1).
compress_same_items(Rest, [_, 0], Rest).


%compress and decompress
compress3([], []).

compress3([Item|Uncompressed], [[Item, Count]|Compressed]) :-
    cm3([Item|Uncompressed], [Item,0], [[Item, Count]|Compressed]).

%end of compression
cm3([], PrevItemAcc, [PrevItemAcc]).

%end of group decompression,
cm3([Item|Uncompressed], [Item,PrevCount], [[Item, KnownCount]|Compressed]) :-
    nonvar(KnownCount),
    succ(PrevCount, KnownCount),
    compress3(Uncompressed,Compressed).

%continue compressing same group
cm3([Item|Uncompressed], [Item,Acc], [[Item, Count]|Compressed]) :-
    succ(Acc,AccInc),
    cm3(Uncompressed, [Item,AccInc], [[Item, Count]|Compressed]).  

%group summary, compress next group
cm3([Item|Uncompressed], PrevItemAcc, [PrevItemAcc|[[Item, Count]|Compressed]]) :-
    cm3([Item|Uncompressed], [Item,0], [[Item, Count]|Compressed]).


:- begin_tests(compress3).
%run_tests(compress3).
%TODO: fix Test succeeded with choicepoint

test(compress_simple) :-
        compress3([a],A1),
        A1 == [[a,1]].

test(decompress_simple) :-
        compress3(A1,[[a,1]]),
        A1 == [a].

test(compress_sophisticated) :-
        compress3([a,b,b,c,c,c,d],A2),
        A2 == [[a,1], [b,2], [c,3],[d,1]].

test(decompress_sophisticated) :-
        compress3(A4, [[a,1], [b,2], [c,3],[d,1]]),
        A4 == [a,b,b,c,c,c,d].
:- end_tests(compress3).