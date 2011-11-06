% Autor: Steffen Flemming, Till Kahlbrock
% Datum: 02.11.2011

:- ensure_loaded(readsentence).
:- ensure_loaded(stammbaum).

start :-
      frage_lesen(Satz),
      frage_verarbeiten(Satz,Semantik),
      %writeln('Struktur: '), writeln(Semantik), nl, % Nur zum Debuggen!!!
      stammbaum_fragen(Semantik).

% ----------------------------------
% Anfrage an den Stammbaum stellen |
% ----------------------------------

% Wenn ein Argument eine ungebundene Variable ist,
% wird das Prädikat ausgeführt (call) und die dann gebundene
% Variable ausgegeben (als Antwort auf eine Wer-ist-Frage)
stammbaum_fragen([Funktor,Arg1,Arg2]) :- var(Arg1), Struktur =.. [Funktor,Arg1,Arg2], call(Struktur),!, writeln(Arg1).
stammbaum_fragen([Funktor,Arg1,Arg2,Arg3]) :- Struktur =.. [Funktor,Arg1,Arg2,Arg3], call(Struktur),!, writeln('Ja').
stammbaum_fragen([Funktor,Arg1,Arg2,Arg3]) :- Struktur =.. [Funktor,Arg1,Arg2,Arg3], call(Struktur),!, writeln('Ja').
stammbaum_fragen([_,Arg1,_]) :- var(Arg1), writeln('Das weiß ich nicht...').

% Wenn alle Variablen gebunden sind (ist-Frage), wird das Prädikat
% ausgeführt und, wenn die Anfrage positiv beantwortet wurde, 'Ja' ausgegeben
stammbaum_fragen(Semantik) :- Struktur =.. Semantik, call(Struktur),!, writeln('Ja!').

% Sonst 'Nein' als Antwort ausgeben
stammbaum_fragen(_) :- writeln('Nein!').
      
% Liest einen Satz vom Benutzer von der Eingabezeile.
frage_lesen(Satz) :- read_sentence(Satz).

% Pruefen, ob die Frage korrekt formuliert wurde (mit der Gramatik
% erzeugt werden kann)
frage_verarbeiten(Satz,Semantik) :- frage(Semantik,Satz,[?]).

% Unterscheidung, ob Frage eine Ist-Frage, Wer-ist-Frage, Wer-sind-Frage
% oder etwas anderes ist.
frage(Semantik) --> ist_frage(Semantik).
frage(Semantik) --> wer_ist_frage(Semantik).
frage(Semantik) --> wer_sind_frage(Semantik).
frage(Semantik) --> sind_frage(Semantik).
frage(_) --> {writeln('Das weiß ich nicht...')}.

% Verarbeitung der Wer-ist-Frage
wer_ist_frage([SemPraed,_,SemObj]) --> wer_ist, praed_phrase(SemPraed,N), obj_phrase(SemObj,N).
wer_ist --> [wer,ist], {lex(wer_ist,_,verb,_)}.

% Verarbeitung der Wer-sind-irgendwas-von-wem-Frage
wer_sind_frage([SemPraed,_,_,SemObj]) --> wer_sind, praed_phrase(SemPraed,N), obj_phrase(SemObj,N).
wer_sind --> [wer,sind], {lex(wer_sind,_,verb,_)}.

% Verarbeitung der Ist-Frage
ist_frage([SemPraed,SemSubj,SemObj]) --> ist, subj(SemSubj,N), praed_phrase(SemPraed,N), obj_phrase(SemObj,N).
ist --> [ist], {lex(ist,_,verb,_)}.

% Verarbeitung der Sind-X-undY-irgendwas-Frage
sind_frage([SemPraed,SemSubj1,SemSubj2]) --> sind, subj(SemSubj1,N), und, subj(SemSubj2,N), praed_phrase_ohne_artikel(SemPraed,_).
sind_frage([SemPraed,SemSubj1,SemSubj2,SemObj]) --> sind, subj(SemSubj1,N), und, subj(SemSubj2,N), praed_phrase_ohne_artikel(SemPraed,_), obj_phrase(SemObj,N).
sind --> [sind], {lex(sind,_,verb,_)}.
und --> [und], {lex(und,_,bindewort,_)}.

% -------------------------
% Definition der Gramatik |
% -------------------------

subj(SemSubj,N) --> nomen(SemSubj,N).
nomen(SemNomen,N) --> [X], {lex(X,SemNomen,nomen,N)}.

praed_phrase(SemPraed,N) --> artikel(_,N), praed(SemPraed,N).
praed_phrase_ohne_artikel(SemPraed,N) --> praed(SemPraed,N).
artikel(_,N) --> [X], {lex(X,_,artikel,N)}.
praed(SemPraed,N) --> [X], {lex(X,SemPraed,praedikat,N)}.

obj_phrase(SemObj,N) --> praeposition(_,N), obj(SemObj,N).
praeposition(_,N) --> [X], {lex(X,_,praeposition,N)}.
obj(SemObj,N) --> [X], {lex(X,SemObj,nomen,N)}.

% ---------
% Lexikon |
% ---------

% Namen der Familienangehoerigen
lex(Name,Name,nomen,sg) :- maennlich(Name).
lex(Name,Name,nomen,sg) :- weiblich(Name).

% Worte, die die Frageart festlegen
lex(ist,ist,verb,sg).
lex(wer_ist,wer_ist,verb,sg).
lex(wer_sind,wer_sind,verb,sg).
lex(sind,sind,verb,sg).

% Praedikate
lex(kind,ist_kind,praedikat,sg).
lex(mutter,ist_mutter,praedikat,sg).
lex(vater,ist_vater,praedikat,sg).
lex(eltern,sind_eltern,praedikat,sg).
lex(neffe,ist_neffe,praedikat,sg).
lex(tante,ist_tante,praedikat,sg).
lex(grosstante,ist_grosstante,praedikat,sg).
lex(grossmutter,ist_grossmutter,praedikat,sg).
lex(schwager,ist_schwager,praedikat,sg).
lex(schwippschwager,ist_schwippschwager,praedikat,sg).
lex(cousin,ist_cousin,praedikat,sg).
lex(ehemann,sind_verheiratet,praedikat,sg).
lex(ehefrau,sind_verheiratet,praedikat,sg).
lex(verheiratet,sind_verheiratet,praedikat,sg).
lex(bruder,sind_geschwister,praedikat,sg).
lex(schwester,sind_geschwister,praedikat,sg).
lex(geschwister,sind_geschwister,praedikat,sg).
lex(halbschwester,sind_halbgeschwister,praedikat,sg).
lex(halbbruder,sind_halbgeschwister,praedikat,sg).
lex(halbgeschwister,sind_halbgeschwister,praedikat,sg).

% Artikel, Praepositionen, Sonstiges
lex(ein,ein,artikel,_).
lex(der,der,artikel,_).
lex(die,die,artikel,_).
lex(das,das,artikel,_).
lex(von,von,praeposition,_).
lex(und,und,bindewort,_).