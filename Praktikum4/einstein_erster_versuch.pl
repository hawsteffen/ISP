% Autor:
% Datum: 06.12.2011

einstein(B,T,F,Z,G,P) :-
                      bewohner(B),
                      tier(T),
                      farbe(F),
                      zigarette(Z),
                      getraenk(G),
                      position(P),
                      bew_farbe_constr(B,F),
                      ...


bewohner(B):-...
tier(T):-...
farbe(F) :- member(F,[rot,blau,gelb,gruen,weiss]).
zigarette(Z):-...
getraenk(G):-...
position(P):-...

bew_farbe_constr(brite,rot).
bew_farbe_constr(norweger,blau) :- !, fail.
bew_farbe_constr(_,rot) :- !,fail.
bew_farbe_constr(_,_):- true.

