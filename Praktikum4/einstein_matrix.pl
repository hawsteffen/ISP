% Autor:
% Datum: 13.12.2011

:- ensure_loaded(matrix).
:- ensure_loaded(output).

solve :-
        einstein(NationM,FarbenM,GetraenkM,TierM,ZigarrenM),!,
        write_houses(NationM,FarbenM,GetraenkM,TierM,ZigarrenM,1).

einstein(NationM,FarbenM,GetraenkM,TierM,ZigarrenM) :-
                                                    matrix(NationM),

                                                    % 9. Der Norweger(3) lebt im ersten Haus(1)
                                                    sum(NationM,3,1),
                                                    matrix(FarbenM),

                                                    % 4. Das grüne Haus(2) steht links neben dem weißen Haus(5)
                                                    sum(FarbenM,2,X10),
                                                    sum(FarbenM,5,Y10),
                                                    Y10 is X10+1,

                                                    % 1. Der Brite(1) lebt im roten Haus(1)
                                                    sum(NationM,1,X11),
                                                    sum(FarbenM,1,X11),

                                                    % 13. Der Norweger(3) wohnt neben dem blauen Haus(4)
                                                    sum(NationM,3,X15),
                                                    sum(FarbenM,4,Y15),
                                                    abs(X15-Y15,1),
                                                    matrix(GetraenkM),

                                                    % 7. Der Mann im mittleren Haus(3) trinkt Milch(5)
                                                    sum(GetraenkM,5,3),

                                                    % 5. Der Besitzer des grünen Hauses(2) trinkt Kaffee(2)
                                                    sum(FarbenM,2,X4),
                                                    sum(GetraenkM,2,X4),

                                                    % 3. Der Däne(2) trinkt gern Tee(1)
                                                    sum(NationM,2,X5),
                                                    sum(GetraenkM,1,X5),
                                                    matrix(ZigarrenM),

                                                    % 8. Der Bewohner des gelben Hauses(3) raucht Dunhill(2)
                                                    sum(FarbenM,3,X3),
                                                    sum(ZigarrenM,2,X3),

                                                    % 14. Der Deutsche(4) raucht Rothmanns(5)
                                                    sum(NationM,4,X6),
                                                    sum(ZigarrenM,5,X6),

                                                    % 12. Der Winfield-Raucher(3) trinkt gern Bier(3)
                                                    sum(GetraenkM,3,X8),
                                                    sum(ZigarrenM,3,X8),
                                                    matrix(TierM),

                                                    % 2. Der Schwede(5) hält sich einen Hund(3)
                                                    sum(NationM,5,X7),
                                                    sum(TierM,3,X7),

                                                    % 6. Die Person, die Pall Mall(1) raucht, hat einen Vogel(1)
                                                    sum(TierM,1,X9),
                                                    sum(ZigarrenM,1,X9),

                                                    % 10. Der Malboro-Raucher(4) wohnt neben der Person mit der Katze(4)
                                                    sum(ZigarrenM,4,X12),
                                                    sum(TierM,4,Y12),
                                                    abs(X12-Y12,1),

                                                    % 11. Der Mann mit dem Pferd(2) lebt neben der Person, die Dunhill(2) raucht
                                                    sum(TierM,2,Y13),
                                                    sum(ZigarrenM,2,X13),
                                                    abs(X13-Y13,1),

                                                    % 15. Der Malboro-Raucher(4) hat einen Nachbarn, der Wasser(4) trinkt
                                                    sum(ZigarrenM,4,X14),
                                                    sum(GetraenkM,4,Y14),
                                                    abs(X14-Y14,1).


% Summiert die Werte einer Spalte multipliziert mit der Position des Wertes
% Beispiel
% sum(M,3,2) bedeutet: in Matrix M in Spalte 3 steht an der Position 2 der Wert 1.
% Die Werte an allen anderen Positionen sind laut Vorbedingung 0.
sum(Matrix,Spalte,Ergebnis) :- sum(Matrix,Spalte,Ergebnis,1,0).

sum([[]],_,Ergebnis,_,Ergebnis).
sum([Zeile|Rest],Spalte,Ergebnis,I,Sum) :-
                                    ergebnis_zeile(Zeile,Spalte,I,ErgebnisZeile),
                                    Sum2 is Sum + ErgebnisZeile,
                                    I2 is I+1,
                                    sum(Rest,Spalte,Ergebnis,I2,Sum2).

% Berechnet (WertDesFeldes * ZeilenNr) für jede Zeile
ergebnis_zeile(Zeile,Spalte,I,ErgebnisZeile) :- ergebnis_zeile(Zeile,Spalte,1,I,ErgebnisZeile).
ergebnis_zeile([Feld|_],Spalte,Spalte,I,ErgebnisZeile) :- ErgebnisZeile is Feld * I.
ergebnis_zeile([_|Rest],Spalte,SpalteAktuell,I,ErgebnisZeile) :-
                                                SpalteAktuell2 is SpalteAktuell+1,
                                                ergebnis_zeile(Rest,Spalte,SpalteAktuell2,I,ErgebnisZeile).


