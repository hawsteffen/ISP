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
% Offene Frage.
stammbaum_fragen([Funktor, Arg1, Arg2]) :-
                           var(Arg1),
                           Struktur =.. [Funktor, Arg1, Arg2],
                           writeln(Struktur),
                           findall(Arg1,Struktur,Ergebnis),
                           antwort(Ergebnis).

% Wenn alle Variablen gebunden sind (geschlossene Frage), wird das Prädikat
% ausgeführt. Wenn die Anfrage positiv beantwortet wurde, 'Ja' ausgegeben
stammbaum_fragen(Semantik) :- Struktur =.. Semantik, call(Struktur),!, writeln('Ja!').
                                           
% Sonst 'Nein' als Antwort ausgeben
stammbaum_fragen(_) :- writeln('Nein!').

% Antwort ausgeben
antwort([]) :- writeln('Keine Ahnung...').
antwort([K|[]]) :- write(K).
antwort([K,R]) :- write(K), write(' und '), antwort(R).

% Unterscheidung, ob Frage eine offene, geschlossene,
% oder etwas anderes ist.
frage(Semantik) --> geschlossene_frage(Semantik).
frage(Semantik) --> offene_frage(Semantik).
frage(_) --> {writeln('Das weiß ich nicht...')}.

% Verarbeitung der verschiedenen Frage
geschlossene_frage([SemNP1,SemNomen,SemNP2]) --> verb(_,N), nomen(SemNomen,N), nominal_phrase(SemNP1,N), nominal_phrase(SemNP2,N).
offene_frage([SemNP1,_,SemNP2]) --> frage_wort(_,_), verb(_,N), nominal_phrase(SemNP1,N), nominal_phrase(SemNP2,N).

nominal_phrase(SemNom,N) --> artikel(_,_), nomen(SemNom,N).
nominal_phrase(SemNom,N) --> praeposition(_,_), nomen(SemNom,N).

verb(_,N) --> [X], {lex(X,_Sem,verb,N)}.
frage_wort(_,_) --> [X], {lex(X,_Sem,frage_wort,_N)}.

% -------------------------
% Definition der Gramatik |
% -------------------------
nomen(SemNomen,N) --> [X], {lex(X,SemNomen,nomen,N)}.
artikel(_,N) --> [X], {lex(X,_Sem,artikel,N)}.
praeposition(_,N) --> [X], {lex(X,_,praeposition,N)}.

% ---------
% Lexikon |
% ---------

lex(wer,wer,frage_wort,sg).
lex(ist,ist,verb,sg).
lex(sind,sind,verb,pl).

% Namen der Familienangehoerigen
lex(Name,Name,nomen,sg) :- maennlich(Name).
lex(Name,Name,nomen,sg) :- weiblich(Name).

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