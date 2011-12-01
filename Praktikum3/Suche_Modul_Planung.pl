% Die Schnittstelle umfasst
%   start_description   ;Beschreibung des Startzustands
%   start_node          ;Test, ob es sich um einen Startknoten handelt
%   goal_node           ;Test, ob es sich um einen Zielknoten handelt
%   state_member        ;Test, ob eine Zustandsbeschreibung in einer Liste 
%                        von Zustandsbeschreibungen enthalten ist
%   expand              ;Berechnung der Kind-Zustandsbeschreibungen
%   eval-path           ;Bewertung eines Pfades

start_description(X):- start_new(5,X).

goal_description(X):- goal_new(5,X).


% Definition des Startknotens
start_node((start,_,_)).

% Definition des Zielknotens
goal_node((_,State,_)):-
  goal_description(Goal),
  state_member(State,[Goal]).



% State-member
% Prueft, ob ein Zustand Teil eines anderen Zustands ist
% z.B.: "Ist der aktuelle Zustand Teil des Zielzustands?"
state_member(_,[]):- !,fail.

state_member(State,[FirstState|_]):-
  mysubset(State,FirstState).
  
%Es ist sichergestellt, dass die beiden ersten Klauseln nicht zutreffen.
state_member(State,[_|RestStates]):-  
  state_member(State,RestStates).

% Hilfskonstrukt, weil das PROLOG "subset" nicht die Unifikation von Listenelementen
% durchführt, wenn Variablen enthalten sind. "member" unifiziert hingegen.
%
mysubset([],_).

mysubset([H|T],List):-
  member(H,List),
  mysubset(T,List).

%--------------------------------
eval_path(Suchverfahren,Path):-
  length(Path,G),
  eval_state(Suchverfahren,Path,G).

% Implementierung der Suchverfahren
%-----------------------------------
% Die Suchverfahren unterscheiden sich eigentlich nur
% darin, wie der Value (f(n)) berechnet wird

% A
eval_state(a,[(_,State,Value)|_],G) :-
  heuristik(wrong_pos,State,Heuristik),
  Value is Heuristik + G.
  
% A*
eval_state(astar,[(_,State,Value)|_],G) :-
  heuristik(wrong_pos_astar,State,Heuristik),
  Value is Heuristik + G.
  
% Gierige Bestensuche
eval_state(greedy,[(_,State,Heuristik)|_],_) :-
  heuristik(wrong_pos,State,Heuristik).

% Bewertungsheuristiken
%-----------------------

% Anzahl der Elemente, die schon an der richtigen Position sind
heuristik(right_pos,State,Value) :-
  goal_description(Ziel),
  schnittmenge(State,Ziel,Schnitt),
  length(Schnitt,AnzSchnitt),
  length(Ziel,AnzZiel),
  Value is (AnzZiel - AnzSchnitt).
  
% Anzahl der Elemente des Ziels, die noch an der falschen Position sind.
heuristik(wrong_pos,State,Value) :-
  goal_description(Ziel),
  differenzmenge(Ziel,State,Differenz),
  length(Differenz,Value).
  
% Anzahl der Elemente des Ziels, die noch an der falschen Position sind.
% Dieser Wert wird am Ende noch durch 3 geteilt, um ein ueberschaetzen zu
% verhindern (es koenne max. 3 Ziele pro Schritt erreicht werden, s. AddList)
heuristik(wrong_pos_astar,State,Value) :-
  goal_description(Ziel),
  differenzmenge(Ziel,State,Differenz),
  length(Differenz,BetragDifferenz),
  ceiling(BetragDifferenz / 3,Value).

% Entfernung zum Ziel immer 0 (=Uniformierte Breitensuche)
heuristik(zero,_,0).

% Aktionen
%----------
action(pick_up(X),
       [handempty, clear(X), on(table,X)],
       [handempty, clear(X), on(table,X)],
       [holding(X)]).

action(pick_up(X),
       [handempty, clear(X), on(Y,X), block(Y)],
       [handempty, clear(X), on(Y,X)],
       [holding(X), clear(Y)]).

action(put_on_table(X),
       [holding(X)],
       [holding(X)],
       [handempty, clear(X), on(table,X)]).

action(put_on(Y,X),
       [holding(X), clear(Y)],
       [holding(X), clear(Y)],
       [handempty, clear(X), on(Y,X)]).



% Liefert Aktionen, die vom momentanen Zustand aus möglich sind
%-----------------------------------------------------------------
expand_help(State,Name,NewState):-
  action(Name, CondList, DelList, AddList),
  ist_teilmenge(CondList,State),
  differenzmenge(State,DelList,StateDel),
  vereinigungsmenge(StateDel,AddList,NewState).

expand((_,State,_),Result):-
  findall((Name,NewState,_),expand_help(State,Name,NewState),Result).

% Mengenoperationen
%-------------------
% differenzmenge(Menge_A, Menge_B, Differenzmenge)
differenzmenge([], _, []).
differenzmenge([Element|Tail], Menge, Rest) :-
        member(Element, Menge), !,
        differenzmenge(Tail, Menge, Rest).
differenzmenge([Head|Tail], Menge, [Head|Rest]) :-
        differenzmenge(Tail, Menge, Rest).

% vereinigungsmenge(Menge_A, Menge_B, Menge_C)
vereinigungsmenge([], Liste, Liste).
vereinigungsmenge([Head|Tail], Liste, Rest) :-
        member(Head, Liste), !,
        vereinigungsmenge(Tail, Liste, Rest).
vereinigungsmenge([Head|Tail], Liste, [Head|Rest]) :-
        vereinigungsmenge(Tail, Liste, Rest).

% ist_teilmenge(Teilmenge, Menge)
ist_teilmenge([], _).
ist_teilmenge([Element|Rest], Menge) :-
        member(Element, Menge),
        ist_teilmenge(Rest, Menge).
        
% schnittmenge(Menge_A, Menge_B, Menge_C)
schnittmenge([], _, []).
schnittmenge([Element|Tail], Liste, Schnitt) :-
        member(Element, Liste), !,
        Schnitt = [Element|Rest],
        schnittmenge(Tail, Liste, Rest).
schnittmenge([_|Tail], Liste, Rest) :-
        schnittmenge(Tail, Liste, Rest).
