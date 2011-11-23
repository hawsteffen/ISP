% Die Schnittstelle umfasst
%   start_description   ;Beschreibung des Startzustands
%   start_node          ;Test, ob es sich um einen Startknoten handelt
%   goal_node           ;Test, ob es sich um einen Zielknoten handelt
%   state_member        ;Test, ob eine Zustandsbeschreibung in einer Liste 
%                        von Zustandsbeschreibungen enthalten ist
%   expand              ;Berechnung der Kind-Zustandsbeschreibungen
%   eval-path           ;Bewertung eines Pfades


start_description([
  block(block1),
  block(block2),
  block(block3),
  block(block4),  %mit Block4
  on(table,block2),
  on(table,block3),
  on(block2,block1),
  on(table,block4), %mit Block4
  clear(block1),
  clear(block3),
  clear(block4), %mit Block4
  handempty
  ]).

goal_description([
  block(block1),
  block(block2),
  block(block3),
  block(block4), %mit Block4
  on(block4,block2), %mit Block4
  on(table,block3),
  on(table,block1),
  on(block1,block4), %mit Block4
  %on(block1,block2), %ohne Block4
  clear(block3),
  clear(block2),
  handempty
  ]).



start_node((start,_,_)).

goal_node((_,State,_)):-
  goal_description(Goal),
  state_member(State,[Goal]).



% Aufgrund der Komplexität der Zustandsbeschreibungen kann state_member nicht auf 
% das Standardprädikat member zurückgeführt werden.
%  
state_member(_,[]):- !,fail.

state_member(State,[FirstState|_]):-
  length(State,L),
  length(FirstState,L),
  differenzmenge(State,FirstState,[]),!.

%Es ist sichergestellt, dass die beiden ersten Klauseln nicht zutreffen.
state_member(State,[_|RestStates]):-  
  state_member(State,RestStates).

%eval_path([(_,_,0)|_]).
eval_path([(_,State,Value)|_]):-
  eval_state(State,Value).

eval_state(State,Value) :-
  goal_description(Ziel),
  schnittmenge(State,Ziel,Schnitt),
  length(Schnitt,Value).
  

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


% Hilfskonstrukt, weil das PROLOG "subset" nicht die Unifikation von Listenelementen 
% durchführt, wenn Variablen enthalten sind. "member" unifiziert hingegen.
%
mysubset([],_).
mysubset([H|T],List):-
  member(H,List),
  mysubset(T,List).


expand_help(State,Name,NewState):-
  member(block(Block), State),
  Name = pick_up(Block),
  action(pick_up(Block), CondList, DelList, AddList),
  ist_teilmenge(CondList,State),
  differenzmenge(State,DelList,StateDel),
  vereinigungsmenge(StateDel,AddList,NewState).
  
expand_help(State,Name,NewState):-
  member(block(Block), State),
  Name = put_on_table(Block),
  action(put_on_table(Block), CondList, DelList, AddList),
  ist_teilmenge(CondList,State),
  differenzmenge(State,DelList,StateDel),
  vereinigungsmenge(StateDel,AddList,NewState).
  
expand_help(State,Name,NewState):-
  member(block(Block1), State),
  member(block(Block2), State),
  Name = put_on(Block1,Block2),
  action(put_on(Block1,Block2), CondList, DelList, AddList),
  ist_teilmenge(CondList,State),
  differenzmenge(State,DelList,StateDel),
  vereinigungsmenge(StateDel,AddList,NewState).

expand((_,State,_),Result):-
  findall((Name,NewState,_),expand_help(State,Name,NewState),Result).

%%%%%%%%%%%%%%%%%%%%%%%
% Mengenoperationen   %
%%%%%%%%%%%%%%%%%%%%%%%
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
