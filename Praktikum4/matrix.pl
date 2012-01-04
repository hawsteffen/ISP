% Autor:
% Datum: 13.12.2011

feld(X) :- member(X,[0,1]).

zeilen(Zeile,Spalten) :- zeilen(Zeile,Spalten,0).

zeilen([],0,1) :- !.
zeilen([],0,_) :- !,fail.
zeilen([H|Rest],Spalten,Sum) :-
                     feld(H),
                     Sum2 is Sum+H,
                     S is Spalten-1,
                     zeilen(Rest,S,Sum2).


matrix(Matrix) :- matrix(Matrix,5,5,[0,0,0,0,0]).

matrix([[]],0,_,[1,1,1,1,1]) :- !.
matrix([[]],0,_,_) :- !,fail.
matrix([[H1,H2,H3,H4,H5]|Rest],Zeilen,Spalten,[S1,S2,S3,S4,S5]) :-
                      zeilen([H1,H2,H3,H4,H5],Spalten),
                      S11 is S1 + H1, S11 =< 1,
                      S21 is S2 + H2, S21 =< 1,
                      S31 is S3 + H3, S31 =< 1,
                      S41 is S4 + H4, S41 =< 1,
                      S51 is S5 + H5, S51 =< 1,
                      Z is Zeilen-1,
                      matrix(Rest,Z,Spalten,[S11,S21,S31,S41,S51]).
                      

