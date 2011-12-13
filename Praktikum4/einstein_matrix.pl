% Autor:
% Datum: 13.12.2011

:- ensure_loaded(matrix).

solve :-
        einstein(NationM,FarbenM,GetraenkM,TierM,ZigarrenM),!,
        write_houses(NationM,FarbenM,GetraenkM,TierM,ZigarrenM,1).

einstein(NationM,FarbenM,GetraenkM,TierM,ZigarrenM) :-
                                                    matrix(NationM),
                                                    % 1: der Norweger(3) wohnt im ersten Haus(1)
                                                    sum(NationM,3,1),
                                                    matrix(FarbenM),
                                                    % 10: The green house(2) is situated immediately to the left of the white house(5)
                                                    sum(FarbenM,2,X10),
                                                    sum(FarbenM,5,Y10),
                                                    Y10 is X10+1,
                                                    % 11: The British person(1) lives in the red house(1)
                                                    sum(NationM,1,X11),
                                                    sum(FarbenM,1,X11),
                                                    % 15: The Norwegian(3) lives next to the blue house(4)
                                                    sum(NationM,3,X15),
                                                    sum(FarbenM,3,Y15),
                                                    abs(X15-Y15,1),
                                                    matrix(GetraenkM),
                                                    % 2: die Person im mittleren Haus(3) trinkt Milch(5)
                                                    sum(GetraenkM,5,3),
                                                    % 4: The person living in green house(2) drinks coffee(2).
                                                    sum(FarbenM,2,X4),
                                                    sum(GetraenkM,2,X4),
                                                    % 5: The Dane(2) drinks tea(1)
                                                    sum(NationM,2,X5),
                                                    sum(GetraenkM,1,X5),
                                                    matrix(ZigarrenM),
                                                    % 3: Person living in the yellow house(3) smokes Dunhill(2)
                                                    sum(FarbenM,3,X3),
                                                    sum(ZigarrenM,2,X3),
                                                    % 6: The German(4) smokes Prince(5)
                                                    sum(NationM,4,X6),
                                                    sum(ZigarrenM,5,X6),
                                                    % 8: The beer drinker(3) smokes BlueMaster(3)
                                                    sum(GetraenkM,3,X8),
                                                    sum(ZigarrenM,3,X8),
                                                    matrix(TierM),
                                                    % 7: The Swede(5) has a dog(3)
                                                    sum(NationM,5,X7),
                                                    sum(TierM,3,X7),
                                                    %9: The bird owner(1) smokes Pall Mall(1)
                                                    sum(TierM,1,X9),
                                                    sum(ZigarrenM,1,X9),
                                                    % 12: The person who smokes Blend(4) lives next to the one who keeps cats(4)
                                                    sum(ZigarrenM,4,X12),
                                                    sum(TierM,4,Y12),
                                                    abs(X12-Y12,1),
                                                    % 13: The person who keeps horses(2) lives next to the person who smokes Dunhill(2)
                                                    sum(TierM,2,Y13),
                                                    sum(ZigarrenM,2,X13),
                                                    abs(X13-Y13,1),
                                                    % 14: The person who smokes Blend(4) has a neighbour who drinks water(4)
                                                    sum(ZigarrenM,4,X14),
                                                    sum(GetraenkM,4,Y14),
                                                    abs(X14-Y14,1).


                                                    
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
       write('Haus'),write(Hnr),
       write(': ('),write(Nation),
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
zigarre(3,bluemaster).
zigarre(4,blend).
zigarre(5,prince).
