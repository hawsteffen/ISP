<<<<<<< HEAD
transportiere(1, Von, _, Nach) :-
  write('Bringe eine Scheibe von '), write(Von), write(' nach '), write(Nach), write(.), nl.  

transportiere(AnzahlScheiben, Von, Lager, Nach) :-
  AnzahlScheiben > 1,
  ObereScheiben is AnzahlScheiben - 1,
  transportiere(ObereScheiben, Von, Nach, Lager),
  transportiere(1, Von, Lager, Nach),
  transportiere(ObereScheiben, Lager, Von, Nach).
  
 
=======
transportiere(1, Von, _, Nach) :-
  write('Bringe eine Scheibe von '), write(Von), write(' nach '), write(Nach), write(.), nl.  

transportiere(AnzahlScheiben, Von, Lager, Nach) :-
  AnzahlScheiben > 1,
  ObereScheiben is AnzahlScheiben - 1,
  transportiere(ObereScheiben, Von, Nach, Lager),
  transportiere(1, Von, Lager, Nach),
  transportiere(ObereScheiben, Lager, Von, Nach).
>>>>>>> b9510605f22ad4e959056025ad70da826ccbf7c9
