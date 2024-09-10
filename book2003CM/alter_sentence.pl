change(you, i).
change(are, [am, not]).
change(french, german).
change(do, no).
change(X, X). % catch all

alter([],[]).
alter([H|T], [X,Y]):- change(H,X), alter(T,Y).

%   EN        PL
% bicycle = rower
% fork = widelec
% frame = rama
% hub  = piasta
% axle = oœ

basicpart(rim).       % obrecz
basicpart(spoke).     % szprycha
basicpart(rearframe).
basicpart(handles).   % uchwyty/kierownica
basicpart(gears).     % zebatki
basicpart(bolt).      % sruba
basicpart(nut).       % nakretka
basicpart(fork).      % widelec

assembly(bike, [wheel, wheel, frame]).
assembly(wheel, [spoke, rim, hub]).
assembly(frame, [rearframe, frontframe]).
assembly(frontframe, [fork, handles]).
assembly(hub, [gears, axle]).
assembly(axle, [bolt, nut]).


mypartsof(Composite, ResultList):- mypartsof([Composite], [], ResultList).

mypartsof([], Collected, Collected).

mypartsof([Current|More], Collected, ResultList):-
    basicpart(Current),
    mypartsof(More, [Current|Collected], ResultList).

mypartsof([Current|More], Collected, ResultList):-
    assembly(Current, Subparts),
    append(Subparts, More, Parts),
    mypartsof(Parts, Collected, ResultList).


