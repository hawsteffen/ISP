sem(SemS) -->
  np(SemNP,N), vp(SemVP,N),
  {SemVP = [_,SemNP|_], SemS =.. SemVP}.

np(SemN,N) --> pn(SemN,N).
np(SemN,N) --> det(_), n(SemN,N).

vp([SemV,_],N) --> v(SemV,N).
vp([SemV,_,SemNP],N) --> v(SemV,N), np(SemNP,_).

pn(SemN,N) --> [X], {lex(X,SemN,pn,N)}.
n(SemN,N) --> [X], {lex(X,SemN,n,N)}.
v(SemV,N) --> [X], {lex(X,SemV,v,N)}.
det(_) --> [X], {lex(X,_,det,_)}.

lex(john,john,pn,sg).
lex(mary,mary,pn,sg).

lex(man,man,n,sg).
lex(woman,woman,n,sg).
lex(dog,dog,n,sg).
lex(bird,bird,n,sg).
lex(apple,apple,n,sg).
lex(men,man,n,pl).
lex(women,woman,n,pl).
lex(dogs,dog,n,pl).
lex(birds,bird,n,pl).
lex(apples,apple,n,pl).

lex(sings,sing,v,sg).
lex(eats,eat,v,sg).
lex(bites,bite,v,sg).
lex(loves,love,v,sg).
lex(sing,sing,v,pl).
lex(eat,eat,v,pl).
lex(bite,bite,v,pl).
lex(love,love,v,pl).

lex(the,the,det,_).













