% Autor: Steffen Flemming
%        Till Kahlbrock

% Datum: 09.10.2011

maennlich(hans).
maennlich(peter).
maennlich(werner).
maennlich(klaus).
maennlich(gert).

weiblich(petra).
weiblich(ilse).

ist_kind(peter,hans).
ist_kind(werner,ilse).
ist_kind(klaus,peter).
ist_kind(gert,petra).

sind_geschwister(hans,ilse).
sind_geschwister(ilse,hans).

sind_geschwister(peter,petra).
sind_geschwister(petra,peter).

% ----------------------------------------

ist_cousin(X,Y) :-
  maennlich(X),
  ist_kind(X,A),
  sind_geschwister(A,B),
  ist_kind(Y,B).

% ----------------------------------------

ist_neffe(X,Y) :-
  maennlich(X),
  ist_kind(X,A),
  sind_geschwister(Y,A).

%-----------------------------------------

ist_grosstante(X,Y) :-
  weiblich(X),
  ist_kind(Y,A),
  ist_kind(A,B),
  sind_geschwister(B,X).

% Anfragen:
  % ist_cousin(peter,werner).
  % ist_neffe(gert,peter).
  % ist_grosstante(ilse,klaus).