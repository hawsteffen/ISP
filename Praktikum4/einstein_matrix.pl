% Autor:
% Datum: 13.12.2011

:- ensure_loaded(matrix).

solve :-
        einstein(NationM,FarbenM,GetraenkM,TierM,ZigarrenM),!,
        write_houses(NationM,FarbenM,GetraenkM,TierM,ZigarrenM,1).

einstein(NationM,FarbenM,GetraenkM,TierM,ZigarrenM) :-
                                                    matrix(NationM),
                                                    
                                                    % 1: der Norweger wohnt im ersten Haus
                                                    sum(NationM,3,1),
                                                    

                                                    matrix(FarbenM),
                                                    matrix(GetraenkM),
                                                    
                                                    % 2: die Person im mittleren Haus trinkt Milch
                                                    sum(GetraenkM,5,3),
                                                    
                                                    matrix(TierM),
                                                    matrix(ZigarrenM),
                                                    
                                                    % 3: Person living in the yellow house smokes Dunhill
                                                    sum(FarbenM,3,X),
                                                    sum(ZigarrenM,2,X).


                                                    
sum(Matrix,Spalte,Ergebnis) :- sum(Matrix,Spalte,Ergebnis,1,0).

sum([[]],_,Ergebnis,_,Ergebnis).
%sum([],_,_,_,_) :- !,fail.
sum([Zeile|Rest],Spalte,Ergebnis,I,Sum) :-
                                    ergebnis_zeile(Zeile,Spalte,I,ErgebnisZeile),
                                    Sum2 is Sum + ErgebnisZeile,
                                    I2 is I+1,
                                    sum(Rest,Spalte,Ergebnis,I2,Sum2).

ergebnis_zeile([Feld|_],1,I,ErgebnisZeile) :- ErgebnisZeile is Feld * I.
ergebnis_zeile([_|Rest],Spalte,I,ErgebnisZeile) :-
                                                Spalte2 is Spalte-1,
                                                ergebnis_zeile(Rest,Spalte2,I,ErgebnisZeile).

write_houses([],[],[],[],[],_).
write_houses([Nationen|RestN],[Farben|RestF],[Getraenke|RestG],[Tiere|RestT],[Zigarren|RestZ],Hnr) :-
       gib_position(Nationen,PosN),
       nation(PosN,Nation),
       gib_position(Farben,PosF),
       farbe(PosF,Farbe),
       gib_position(Getraenke,PosG),
       getraenk(PosG,Getraenk),
       gib_position(Tiere,PosT),
       tier(PosT,Tier),
       gib_position(Zigarren,PosZ),
       zigarre(PosZ,Zigarre),
       write('Haus('),write(Hnr),
       write(','),write(Nation),
       write(','),write(Farbe),
       write(','),write(Getraenk),
       write(','),write(Tier),
       write(','),write(Zigarre),
       write(')'),nl,
       Hnr2 is Hnr+1,
       write_houses(RestN,RestF,RestG,RestT,RestZ,Hnr2).


gib_position(Zeile,Pos) :- gib_position(Zeile,Pos,1).

gib_position([1|_],Spalte,Spalte).
gib_position([_|Rest],Pos,Spalte) :-
                                     Spalte2 is Spalte+1,
                                     gib_position(Rest,Pos,Spalte2).
                                     
nation(1,brite).
nation(2,daene).
nation(3,norweger).
nation(4,deutscher).
nation(5,schwede).

farbe(1,rot).
farbe(2,gruen).
farbe(3,gelb).
farbe(4,blau).
farbe(5,weiss).

getraenk(1,tee).
getraenk(2,kaffee).
getraenk(3,bier).
getraenk(4,wasser).
getraenk(5,milch).

tier(1,vogel).
tier(2,pferd).
tier(3,hund).
tier(4,katze).
tier(5,fisch).

zigarre(1,pallmall).
zigarre(2,dunhill).
zigarre(3,blumaster).
zigarre(4,blend).
zigarre(5,prince).