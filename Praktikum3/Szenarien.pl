% Autor:
start_new(3,[
  block(block1),
  block(block2),
  block(block3),
  on(table,block2),
  on(table,block3),
  on(block2,block1),
  clear(block1),
  clear(block3),
  handempty
  ]).
  
start_new(4,[
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
  
start_new(5,[
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
  
start_new(6,[
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

start_new(9,[
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

goal_new(3,[
  block(block1),
  block(block2),
  block(block3),
  on(table,block3),
  on(table,block1),
  on(block1,block2),
  clear(block3),
  clear(block2),
  handempty
  ]).

goal_new(4,[
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

goal_new(5,[
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

goal_new(6,[
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

goal_new(9,[
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