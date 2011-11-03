% Autor: Steffen Flemming, Till Kahlbrock
% Datum: 02.11.2011

:- ensure_loaded(readsentence).

start(Semantik) :- read_sentence(Satz), s(Semantik,Satz,[?]).

s(SemS) --> ist(_), ist_frage(Sem), {SemS =.. Sem}.
ist(_) --> [ist], {lex(ist,_,verb,_)}.

ist_frage([SemPraed,SemSubj,SemObj]) --> subj(SemSubj,N), praed_phrase(SemPraed,N), obj_phrase(SemObj,N).

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
lex(ist,ist,verb,sg).
lex(kind,kind,pnomen,sg).
lex(ein,ein,artikel,_).
lex(der,der,artikel,_).
lex(die,die,artikel,_).
lex(das,das,artikel,_).
lex(von,von,praeposition,_).