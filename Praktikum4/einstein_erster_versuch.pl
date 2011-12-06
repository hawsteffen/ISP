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
                      bew_tier_constr(B,T),
                      bew_getraenk_constr(B,G),
                      links_constr(F,P,_,_),
                      farbe_getraenk_constr(F,G),
                      tier_zigaretten_constr(T,Z),
                      getraenk_position_constr(G,P),
                      farbe_zigaretten_constr(F,Z),
                      bewohner_posiion_constr(B,P),
                      getraenk_zigaretten_constr(G,Z),
                      bewohner_zigaretten_constr(B,Z).

% Domaenen
% -----------------------------------------------------------------------------
bewohner(B) :- member(B,[brite,schwede,daene,norweger,deutscher]).
tier(T) :- member(T,[hund,vogel,katze,pferd,fisch]).
farbe(F) :- member(F,[rot,blau,gelb,gruen,weiss]).
zigarette(Z) :- member(Z,[pallmall,dunhill,malboro,winfield,rothmanns]).
getraenk(G) :- member(G,[tee,kaffee,milch,bier,wasser]).
position(P) :- member(P,[1,2,3,4,5]).

% Constraints
% -----------------------------------------------------------------------------

% 1,13
bew_farbe_constr(brite,rot).
bew_farbe_constr(norweger,blau) :- !, fail.
bew_farbe_constr(_,rot) :- !,fail.
bew_farbe_constr(_,_):- true.

% 2
bew_tier_constr(schwede,hund).
bew_tier_constr(_,_) :- true.

% 3
bew_getraenk_constr(daene,tee).
bew_getraenk_constr(_,tee) :- !, fail.
bew_getraenk_constr(_,_) :- true.

% 4
links_constr(gruen,P1,weiss,P2) :- P1 = P2 - 1.
links_constr(gruen,P1,weiss,P2) :- P1 >= P2, !, fail.
links_constr(_,_,_,_) :- true.

% 5
farbe_getraenk_constr(gruen,kaffee).
farbe_getraenk_constr(_,kaffee) :- !, fail.
farbe_getraenk_constr(gruen,_) :- !, fail.
farbe_getraenk_constr(_,_) :- true.

% 6,10,11
tier_zigaretten_constr(vogel,pallmall).
tier_zigaretten_constr(katze,malboro) :- !, fail.
tier_zigaretten_constr(pferd,dunhill) :- !, fail.
tier_zigaretten_constr(_,pallmall) :- !, fail.
tier_zigaretten_constr(_,_) :- true.

% 7
getraenk_position_constr(milch,3).
getraenk_position_constr(milch,_) :- !, fail.
getraenk_position_constr(_,_) :- true.

% 8
farbe_zigaretten_constr(gelb,dunhill).
farbe_zigaretten_constr(_,dunhill) :- !, fail.
farbe_zigaretten_constr(_,_) :- true.

% 9
bewohner_posiion_constr(norweger,1).
bewohner_posiion_constr(_,1) :- !, fail.
bewohner_posiion_constr(norweger,_) :- !, fail.
bewohner_posiion_constr(_,_) :- true.

% 12, 15
getraenk_zigaretten_constr(bier,winfield).
getraenk_zigaretten_constr(wasser,malboro) :- !, fail.
getraenk_zigaretten_constr(_,winfield) :- !, fail.
getraenk_zigaretten_constr(_,_) :- true.

% 14
bewohner_zigaretten_constr(deutscher,rothmanns).
bewohner_zigaretten_constr(_,rothmanns) :- !, fail.
bewohner_zigaretten_constr(_,_) :- true.