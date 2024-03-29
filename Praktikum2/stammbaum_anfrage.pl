% Autor: Steffen Flemming, Till Kahlbrock
% Datum: 02.11.2011
:- module(stammbaum_anfrage,[s/1]).

%:- consult(readsentence).
:- ensure_loaded(readsentence).

s(SemS) --> ist, ist_frage(SemS).
ist --> [ist], {lex(ist,_,verb,_)}.

ist_frage([SemSubj,SemPraed,SemObj]) --> subj(SemSubj,N), praed_phrase(SemPraed,N), obj_phrase(SemObj,N).

subj(SemSubj,N) --> nomen(SemSubj,N).
nomen(SemNomen,N) --> [X], {lex(X,SemNomen,nomen,N)}.

pread_phrase(SemPraed,N) --> artikel(_,N), pread(SemPraed,N).
pread(SemPraed,N) --> [X], {lex(X,SemPraed,pnomen,N)}. %pnomen == Nomen, fuer die wir Preadikate definiert haben (kind/2, mutter/2,...)
artikel(_,N) --> [X], {lex(X,_,artikel,N)}.

obj_phrase(SemObj,N) --> xxx(_,N), obj(SemObj,N).
xxx(_,N) --> [X], {lex(X,_,xxx,N)}.
obj(SemObj,N) --> [X], {lex(X,SemObj,nomen,N)}.

lex(hans,hans,nomen,sg).
lex(peter,peter,nomen,sg).
lex(ist,ist,verb,sg).
lex(verheiratet,verheiratet,adjektiv,_).
lex(kind,kind,pnomen,sg).
lex(der,der,artikel,_).
lex(die,die,artikel,_).
lex(das,das,artikel,_).
lex(von,von,xxx,_).