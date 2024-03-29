% Autor: Steffen Flemming, Till Kahlbrock
% Datum: 02.11.2011

:- ensure_loaded(readsentence).
:- ensure_loaded(stammbaum).

start :-
      frage_lesen(Satz),
      frage_verarbeiten(Satz,Semantik),
      %writeln('Struktur: '), writeln(Semantik), nl, % Nur zum Debuggen!!!
      stammbaum_fragen(Semantik).


% Liest einen Satz vom Benutzer von der Eingabezeile.
frage_lesen(Satz) :- read_sentence(Satz).

% Pruefen, ob die Frage korrekt formuliert wurde (mit der Gramatik
% erzeugt werden kann)
frage_verarbeiten(Satz,Semantik) :- frage(Semantik,Satz,[?]).

% ----------------------------------
% Anfrage an den Stammbaum stellen |
% ----------------------------------
% Wenn ein Argument eine ungebundene Variable ist,
% wird das Pr�dikat ausgef�hrt (call) und die dann gebundene
% Variable ausgegeben (als Antwort auf eine Wer-ist-Frage)
stammbaum_fragen([Funktor,Arg1,Arg2]) :-
                                      var(Arg1),
                                      Struktur =.. [Funktor,Arg1,Arg2],
                                      call(Struktur),
                                      writeln(Arg1).
stammbaum_fragen([_,Arg1,_]) :-
                             var(Arg1),
                             writeln('Das wei� ich nicht...').

stammbaum_fragen([Funktor,Arg1,Arg2,Arg3]) :-
                                           var(Arg1),
                                           var(Arg2),
                                           Struktur =.. [Funktor,Arg1,Arg2,Arg3],
                                           call(Struktur),!,
                                           write(Arg1), write(' und '), writeln(Arg2).

stammbaum_fragen([Funktor,Arg1,Arg2,Arg3]) :-
                                           Struktur =.. [Funktor,Arg1,Arg2,Arg3],
                                           call(Struktur),!,
                                           writeln('Ja').

% Wenn alle Variablen gebunden sind (ist-Frage), wird das Pr�dikat
% ausgef�hrt und, wenn die Anfrage positiv beantwortet wurde, 'Ja' ausgegeben
stammbaum_fragen(Semantik) :- Struktur =.. Semantik, call(Struktur),!, writeln('Ja!').

% Sonst 'Nein' als Antwort ausgeben
stammbaum_fragen(_) :- writeln('Nein!').

% Unterscheidung, ob Frage eine Ist-Frage, Wer-ist-Frage, Wer-sind-Frage
% oder etwas anderes ist.
frage(Semantik) --> geschlossene_frage(Semantik).
frage(Semantik) --> offene_frage(Semantik).

frage(Semantik) --> ist_frage(Semantik).
frage(Semantik) --> wer_ist_frage(Semantik).
frage(Semantik) --> sind_frage(Semantik).
frage(Semantik) --> wer_sind_frage(Semantik).
frage(_) --> {writeln('Das wei� ich nicht...')}.

% Verarbeitung der Ist-Frage
geschlossene_frage([SemVerb,SemNomen]) --> verb(SemVerb,N), nomen(SemNomen,N), nominal_phrase(SemNP1,N), nominal_phrase(SemNP2,N).
offene_frage([SemVerb,SemNomen]) --> frage_wort, verb(SemVerb,N), nominal_phrase(SemNP1,N), nominal_phrase(SemNP2,N).

nominal_phrase(SemNom,N) --> artikel(_,_), nomen(SemNom,N).
nominal_phrase(SemNom,N) --> praeposition(_,_), nomen(SemNom,N).

verb --> [X], {lex(X,_,verb,N)}.



% Verarbeitung der Wer-ist-Frage
wer_ist_frage([SemPraed,_,SemObj]) --> wer_ist, praed_phrase(SemPraed,N), obj_phrase(SemObj,N).

% Verarbeitung der Sind-X-und-Y-irgendwas-Frage
sind_frage([SemPraed,SemSubj1,SemSubj2]) --> sind, subj(SemSubj1,N), und, subj(SemSubj2,N), praed_phrase(SemPraed,_).
sind_frage([SemPraed,SemSubj1,SemSubj2,SemObj]) --> sind, subj(SemSubj1,N), und, subj(SemSubj2,N), praed_phrase(SemPraed,_), obj_phrase(SemObj,N).

% Verarbeitung der Wer-sind-irgendwas-von-wem-Frage
wer_sind_frage([SemPraed,_,_,SemObj]) --> wer_sind, praed_phrase(SemPraed,N), obj_phrase(SemObj,N).

% -------------------------
% Definition der Gramatik |
% -------------------------
und --> [und], {lex(und,_,bindewort,_)}.
ist --> [ist], {lex(ist,_,verb,_)}.
wer_ist --> [wer,ist], {lex(wer_ist,_,verb,_)}.
sind --> [sind], {lex(sind,_,verb,_)}.
wer_sind --> [wer,sind], {lex(wer_sind,_,verb,_)}.

subj(SemSubj,N) --> nomen(SemSubj,N).
nomen(SemNomen,N) --> [X], {lex(X,SemNomen,nomen,N)}.

praed_phrase(SemPraed,N) --> artikel(_,N), praed(SemPraed,N).
praed_phrase(SemPraed,N) --> praed(SemPraed,N).
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
lex(kind,ist_kind,nomen,sg).
lex(kinder,sind_kinder,nomen,pl).
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