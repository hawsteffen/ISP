s --> np(N), vp(N). 

np(N) --> pn(N).
np(N) --> det(N), n(N).

vp(N) --> v(N).
vp(N) --> v(N), np(_).

pn(N) --> [X], {lex(X,pn,N)}.
n(N) --> [X], {lex(X,n,N)}.
v(N) --> [X], {lex(X,v,N)}.
det(N) --> [X], {lex(X,det,N)}.

lex(john,pn,sg).
lex(mary,pn,sg).

lex(man,n,sg).
lex(woman,n,sg).
lex(dog,n,sg).
lex(bird,n,sg).
lex(apple,n,sg).
lex(men,n,pl).
lex(women,n,pl).
lex(dogs,n,pl).
lex(birds,n,pl).
lex(apples,n,pl).

lex(sings,v,sg).
lex(eats,v,sg).
lex(bites,v,sg).
lex(loves,v,sg).
lex(sing,v,pl).
lex(eat,v,pl).
lex(bite,v,pl).
lex(love,v,pl).

lex(the,det,_).





