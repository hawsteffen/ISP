% Autor: Steffen Flemming
%        Till Kahlbrock

% Datum: 09.10.2011

maennlich(hans).
maennlich(peter).
maennlich(werner).
maennlich(klaus).
maennlich(gert).
maennlich(egon).

weiblich(petra).
weiblich(ilse).
weiblich(lisa).
weiblich(mona).
weiblich(maggy).

ist_kind(hans,peter).
ist_kind(hans,petra).
ist_kind(mona,peter).
ist_kind(mona,petra).
ist_kind(ilse,werner).
ist_kind(ilse,petra).
ist_kind(klaus,gert).
ist_kind(klaus,maggy).
ist_kind(egon,gert).
ist_kind(egon,maggy).

sind_verheiratet(mona,klaus).
sind_verheiratet(klaus,mona).

% ----------------------------------------
sind_geschwister(X,Y):-
  sind_eltern(M,V,X),
  sind_eltern(M,V,Y),
  X \= Y.

% ----------------------------------------
sind_eltern(M,V,Kind):-
  ist_mutter(M,Kind),
  ist_vater(V,Kind).

% ----------------------------------------
ist_mutter(X,Y):-
  weiblich(X),
  ist_kind(Y,X).

% ----------------------------------------
ist_vater(X,Y):-
  maennlich(X),
  ist_kind(Y,X).
  
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
ist_tante(X,Y) :-
  weiblich(X),
  ist_mutter(Z,Y),
  sind_geschwister(X,Z).

%-----------------------------------------
  
ist_grosstante(GTante,Ich):-
  weiblich(GTante),
  ist_grossmutter(GMutter,Ich),
  sind_geschwister(GMutter,GTante).

%-----------------------------------------

ist_grossmutter(GMutter,Ich):-
  weiblich(GMutter),
  ist_mutter(Mutter,Ich),
  ist_mutter(GMutter,Mutter).
  
%-----------------------------------------

sind_halbgeschwister(HS,Ich):-
  sind_eltern(X,Y,Ich),
  sind_eltern(X,Z,HS),
  Y \= Z.

%-----------------------------------------
ist_schwager(Schwager,Ich):-
  sind_geschwister(Ich,X),
  sind_verheiratet(Schwager,X).

%-----------------------------------------
ist_schwippschwager(SSchwager,Ich):-
  ist_schwager(Schwager,Ich),
  sind_geschwister(Schwager,SSchwager).
