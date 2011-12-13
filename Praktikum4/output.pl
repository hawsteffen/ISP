% Autor:
% Datum: 13.12.2011

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
zigarre(3,winfield).
zigarre(4,malboro).
zigarre(5,rothmanns).