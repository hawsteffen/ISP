% Autor: Steffen Flemming, Till Kahlbrock
% Datum: 02.11.2011

:- ensure_loaded(readsentence).
:- ensure_loaded(stammbaum).

start :-
      frage_lesen(Satz),
      frage_verarbeiten(Satz,Semantik),
      %write('Struktur: '), write(Struktur), nl, % Nur zum Debuggen!!!
      stammbaum_fragen(Semantik).

stammbaum_fragen([Funktor,Arg1,Arg2]) :- var(Arg1), Struktur =.. [Funktor,Arg1,Arg2], call(Struktur),!, writeln(Arg1).
stammbaum_fragen([Funktor,Arg1,Arg2]) :- var(Arg2), Struktur =.. [Funktor,Arg1,Arg2], call(Struktur),!, writeln(Arg2).
stammbaum_fragen(Semantik) :- Struktur =.. Semantik, call(Struktur),!, writeln('JA!').
stammbaum_fragen(_) :- writeln('Nein!').
      
frage_lesen(Satz) :- read_sentence(Satz).
frage_verarbeiten(Satz,Semantik) :- frage(Semantik,Satz,[?]).

frage(Semantik) --> ist_frage(Semantik).
frage(Semantik) --> wer_ist_frage(Semantik).

wer_ist_frage([SemPraed,_,SemObj]) --> wer_ist, praed_phrase(SemPraed,N), obj_phrase(SemObj,N).
wer_ist --> [wer,ist], {lex(wer_ist,_,verb,_)}.

ist_frage([SemPraed,SemSubj,SemObj]) --> ist, subj(SemSubj,N), praed_phrase(SemPraed,N), obj_phrase(SemObj,N).
ist --> [ist], {lex(ist,_,verb,_)}.

subj(SemSubj,N) --> nomen(SemSubj,N).
nomen(SemNomen,N) --> [X], {lex(X,SemNomen,nomen,N)}.

praed_phrase(SemPraed,N) --> artikel(_,N), praed(SemPraed,N).
praed(SemPraed,N) --> [X], {lex(X,SemPraed,pnomen,N)}. %'pnomen' ist Nomen, fuer die wir Preadikate definiert haben (kind/2, mutter/2,...)
artikel(_,N) --> [X], {lex(X,_,artikel,N)}.

obj_phrase(SemObj,N) --> praeposition(_,N), obj(SemObj,N).
praeposition(_,N) --> [X], {lex(X,_,praeposition,N)}.
obj(SemObj,N) --> [X], {lex(X,SemObj,nomen,N)}.

lex(hans,hans,nomen,sg).
lex(peter,peter,nomen,sg).
lex(wer_ist,wer_ist,verb,sg).
lex(ist,ist,verb,sg).
lex(kind,ist_kind,pnomen,sg).
lex(ein,ein,artikel,_).
lex(der,der,artikel,_).
lex(die,die,artikel,_).
lex(das,das,artikel,_).
lex(von,von,praeposition,_).