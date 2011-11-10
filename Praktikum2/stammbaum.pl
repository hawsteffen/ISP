% Autor: Steffen Flemming
%        Till Kahlbrock

% Datum: 09.10.2011

maennlich(hans).
maennlich(peter).
maennlich(werner).
maennlich(klaus).
maennlich(karl).
maennlich(egon).
maennlich(john).
maennlich(willi).
maennlich(herbert).

weiblich(petra).
weiblich(ilse).
weiblich(lisa).
weiblich(mona).
weiblich(maggy).
weiblich(petty).
weiblich(heidi).
weiblich(trude).
weiblich(anke).

ist_kind(hans,peter).
ist_kind(hans,petra).
ist_kind(ilse,peter).
ist_kind(ilse,petra).
ist_kind(lisa,mona).
ist_kind(lisa,peter).
ist_kind(klaus,hans).
ist_kind(egon,ilse).
ist_kind(egon,werner).
ist_kind(petra,maggy).
ist_kind(petra,herbert).
ist_kind(heidi,maggy).
ist_kind(heidi,herbert).
ist_kind(maggy,trude).
ist_kind(maggy,john).
ist_kind(petty,trude).
ist_kind(petty,john).
ist_kind(werner,anke).
ist_kind(werner,willi).
ist_kind(karl,anke).
ist_kind(karl,willi).

sind_verheiratet(peter,petra).
sind_verheiratet(petra,peter).

sind_verheiratet(ilse,werner).
sind_verheiratet(werner,ilse).


% ----------------------------------------
sind_geschwister(X,Y):-
  sind_eltern(M,V,X),
  sind_eltern(M,V,Y),
  X \= Y.
  
% ----------------------------------------
sind_eltern(M,V,Kind):-
  ist_mutter(M,Kind),
  ist_vater(V,Kind).
  
sind_eltern(M,V,Kind) :- sind_eltern(V,M,Kind).

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
  
sind_halbgeschwister(HS,Ich):-
  sind_eltern(Y,X,Ich),
  sind_eltern(Z,X,HS),
  Y \= Z.

%-----------------------------------------
ist_schwager(Schwager,Ich):-
  sind_geschwister(Ich,X),
  sind_verheiratet(Schwager,X).

ist_schwager(X,Y) :- ist_schwager(Y,X).

%-----------------------------------------
ist_schwippschwager(SSchwager,Ich):-
  ist_schwager(Schwager,Ich),
  sind_geschwister(Schwager,SSchwager).
