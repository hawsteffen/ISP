% Autor: Steffen Flemming, Till Kahlbrock
% Datum: 02.11.2011

:- ensure_loaded(readsentence).
:- ensure_loaded(stammbaum).

start :-
      frage_lesen(Satz),
      frage_verarbeiten(Satz,Semantik),
      %write('Struktur: '), write(Struktur), nl, % Nur zum Debuggen!!!
      stammbaum_fragen(Semantik).

% ----------------------------------
% Anfrage an den Stammbaum stellen |
% ----------------------------------
% Wenn das erste Argument eine ungebundene Variable ist,
% wird das Pr�dikat ausgef�hrt (call) und die belegte
% Variable am Schluss ausgegeben (als Antwort auf eine Wer-ist-Frage)
stammbaum_fragen([Funktor,Arg1,Arg2]) :- var(Arg1), Struktur =.. [Funktor,Arg1,Arg2], call(Struktur),!, writeln(Arg1).

% Wenn alle Variablen gebunden sind (ist-Frage), wird das Pr�dikat
% ausgef�hrt und, wenn die Anfrage positiv beantwortet wurde, 'Ja' ausgegeben
stammbaum_fragen(Semantik) :- Struktur =.. Semantik, call(Struktur),!, writeln('JA!').

% Sonst 'Nein' als Antwort ausgeben
stammbaum_fragen(_) :- writeln('Nein!').
      
% Liest einen Satz vom Benutzer von der Eingabezeile.
frage_lesen(Satz) :- read_sentence(Satz).

% Pruefen, ob die Frage korrekt formuliert wurde (mit der Gramatik
% erzeugt werden kann)
frage_verarbeiten(Satz,Semantik) :- frage(Semantik,Satz,[?]).

% Unterscheidung, ob Frage eine Ist-Frage, Wer-ist-Frage
% oder etwas anderes ist.
frage(Semantik) --> ist_frage(Semantik).
frage(Semantik) --> wer_ist_frage(Semantik).
frage(_) --> {writeln('ich habe keine ahnung.')}.

% Verarbeitung der Wer-ist-Frage
wer_ist_frage([SemPraed,_,SemObj]) --> wer_ist, praed_phrase(SemPraed,N), obj_phrase(SemObj,N).
wer_ist --> [wer,ist], {lex(wer_ist,_,verb,_)}.

% Verarbeitung der Ist-Frage
ist_frage([SemPraed,SemSubj,SemObj]) --> ist, subj(SemSubj,N), praed_phrase(SemPraed,N), obj_phrase(SemObj,N).
ist --> [ist], {lex(ist,_,verb,_)}.

% -------------------------
% Definition der Gramatik |
% -------------------------
subj(SemSubj,N) --> nomen(SemSubj,N).
nomen(SemNomen,N) --> [X], {lex(X,SemNomen,nomen,N)}.

praed_phrase(SemPraed,N) --> artikel(_,N), praed(SemPraed,N).
praed(SemPraed,N) --> [X], {lex(X,SemPraed,praedikat,N)}.
artikel(_,N) --> [X], {lex(X,_,artikel,N)}.

obj_phrase(SemObj,N) --> praeposition(_,N), obj(SemObj,N).
praeposition(_,N) --> [X], {lex(X,_,praeposition,N)}.
obj(SemObj,N) --> [X], {lex(X,SemObj,nomen,N)}.

% ---------
% Lexikon |
% ---------

% Namen der Familienangehoerigen
lex(Name,Name,nomen,sg) :- maennlich(Name).
lex(Name,Name,nomen,sg) :- weiblich(Name).

% Worte, die Frageart festlegen
lex(wer_ist,wer_ist,verb,sg).
lex(ist,ist,verb,sg).

% Praedikate
lex(kind,ist_kind,praedikat,sg).
lex(mutter,ist_mutter,praedikat,sg).
lex(vater,ist_vater,praedikat,sg).
lex(neffe,ist_neffe,praedikat,sg).
lex(tante,ist_tante,praedikat,sg).
lex(grosstante,ist_grosstante,praedikat,sg).
lex(grossmutter,ist_grossmutter,praedikat,sg).
lex(schwager,ist_schwager,praedikat,sg).
lex(schwippschwager,ist_schwippschwager,praedikat,sg).

% TODO Preadikate
%-----------------
% sind_verheiratet(X,Y) (Ehefrau/Ehemann)
% sind_geschwister(X,Y) (Schwester/Bruder)
% sind_halbgeschwister(HS,Ich) (Halbschwester/Halbbruder)


% Artikel, Praepositionen, Sonstiges
lex(ein,ein,artikel,_).
lex(der,der,artikel,_).
lex(die,die,artikel,_).
lex(das,das,artikel,_).
lex(von,von,praeposition,_).
