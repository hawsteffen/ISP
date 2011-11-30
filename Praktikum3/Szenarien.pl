% Autor:
% Datum: 30.11.2011

% Original Beispiel
% --------------------------------------------------

start_description([
  block(block1),
  block(block2),
  block(block3),
  block(block4),  %mit Block4
  on(table,block2),
  on(table,block3),
  on(block2,block1),
  on(table,block4), %mit Block4
  clear(block1),
  clear(block3),
  clear(block4), %mit Block4
  handempty
  ]).

goal_description([
  block(block1),
  block(block2),
  block(block3),
  block(block4), %mit Block4
  on(block4,block2), %mit Block4
  on(table,block3),
  on(table,block1),
  on(block1,block4), %mit Block4
  %on(block1,block2), %ohne Block4
  clear(block3),
  clear(block2),
  handempty
  ]).

% Szenario 2  (6 Bloecke)
% --------------------------------------------------
start_description([
  block(block1),
  block(block2),
  block(block3),
  block(block4),
  block(block5),
  block(block6),
  on(table,block2),
  on(table,block6),
  on(block2,block1),
  on(block1,block4),
  on(block4,block3),
  on(block6,block5),
  clear(block3),
  clear(block5),
  handempty
  ]).

goal_description([
  block(block1),
  block(block2),
  block(block3),
  block(block4),
  block(block5),
  block(block6),
  on(table,block1),
  on(table,block2),
  on(table,block3),
  on(block1,block4),
  on(block4,block6),
  on(block2,block5),
  clear(block6),
  clear(block5),
  clear(block3),
  handempty
  ]).

% Szenario 3  (9 Bloecke)
% --------------------------------------------------
start_description([
  block(block1),
  block(block2),
  block(block3),
  block(block4),
  block(block5),
  block(block6),
  block(block7),
  block(block8),
  block(block9),
  on(table,block1),
  on(table,block5),
  on(table,block8),
  on(block5,block4),
  on(block4,block7),
  on(block7,block6),
  on(block1,block2),
  on(block2,block3),
  on(block3,block9),
  clear(block6),
  clear(block8),
  clear(block9),
  handempty
  ]).

goal_description([
  block(block1),
  block(block2),
  block(block3),
  block(block4),
  block(block5),
  block(block6),
  block(block7),
  block(block8),
  block(block9),
  on(table,block3),
  on(table,block6),
  on(table,block9),
  on(block3,block2),
  on(block2,block1),
  on(block6,block5),
  on(block5,block4),
  on(block9,block8),
  on(block8,block7),
  clear(block1),
  clear(block4),
  clear(block7),
  handempty
  ]).
  
% Szenario 4  (5 Bloecke)
% --------------------------------------------------
start_description([
  block(block1),
  block(block2),
  block(block3),
  block(block4),
  block(block5),
  on(table,block1),
  on(table,block3),
  on(table,block4),
  on(block1,block2),
  on(block4,block5),
  clear(block2),
  clear(block3),
  clear(block5),
  handempty
  ]).

goal_description([
  block(block1),
  block(block2),
  block(block3),
  block(block4),
  block(block5),
  on(table,block4),
  on(table,block5),
  on(block4,block2),
  on(block2,block1),
  on(block5,block3),
  clear(block1),
  clear(block3),
  handempty
  ]).
