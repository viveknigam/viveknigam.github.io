module bag.

membNrest X (X::L) L :- print("Found Unload\n").
membNrest X (Y::L) (Y::K) :- membNrest X L K, print("Search Unload\n").

empty Loc In :- not (membNrest (pair Loc _) In _).

success (gr X Y) :- X > Y.
success (leq X Y) :- X =< Y.

failure (gr X Y) :- X =< Y.
failure (leq X Y) :- X > Y.

announce G :-
  print ">> ", term_to_string G String, print String, print "\n", fail.

spy G :-
  (print ">Entering ", term_to_string G Str,  print Str,  print "\n", G,
   print ">Success  ", term_to_string G Strx, print Strx, print "\n";
   print ">Leaving  ", term_to_string G Str,  print Str,  print "\n",
fail).

% interp Prog InStore OutStore

% printSize nil N :- print ("Size of input "),
%                   print(int_to_string(0)),
%                   print ("\n").
% printSize (X::L) N :- print(int_to_string(0)), printSize L (N+1).

append nil K K.
append (X :: L) K (X :: M) :- append L K M.

interp (openDef Name Cont) In Out :- 
                   getDef Name Def,
                   append Def In1 In2, 
                   interp Cont In2 Out. 

interp (load Tup Loc Cont) In Out :- 
 	  print("Load\n"),
          interp Cont ((pair Loc Tup)::In) Out.
interp (unload1 Loc Pat Cont) In Out :- print("Unload\n"),
               membNrest (pair Loc (Pat X)) In Mid, !,
               interp (Cont X) Mid Out.
interp (unload2 Loc Pat Cont) In Out :- 
               membNrest (pair Loc (Pat X Y)) In Mid,
               interp (Cont X Y) Mid Out.

interp (while Conda Body Cont) In Out :-
  (success Conda, interp (Body (while Conda Body Cont)) In Out;
   failure Conda, interp Cont In Out).

interp (loop1 Loc Body Cont) In Out :- print("Entered Loop\n"),
 interp (alt (unload1 Loc (m\ tup1 m) (x\ Body x (loop1 Loc Body Cont)))
             (ifl (is_empty Loc) Cont)) In Out.

interp (loop2 Loc Body Cont) In Out :-
  interp (alt (unload2 Loc Pat (x\y\ Body x y (loop2 Loc Body
Cont)))
              (ifl (is_empty Loc) Cont)) In Out.

interp (alt A B) In Out :- interp A In Out ; interp B In Out.

interp (ifa Conda Cont) In Out :- success Conda, interp Cont In
Out.
interp (ifl (is_empty Loc) Cont) In Out :- empty Loc In,  interp Cont In
Out.

interp done In In.

interp Def In Out :- defs Def Body, interp Body In Out.

defs (extractMin Li Lo Min Cont) 
     ((unload2 Li (n\v\ tup2 n v) (n\v\
            (load (tup2 n v) Min 
            (loop2 Li (n1\v1\k1\ 
                (unload2 Min (n\v\ tup2 n v) (nm\vm\ 
                   (alt (ifa (gr v1 nm) (load (tup2 nm vm) Min 
                             (load (tup2 n1 v1) Lo k1 ))) 
                        (ifa (leq v1 nm) (load (tup2 n1 v1) Min 
                             (load (tup2 nm vm) Lo k1 )))))))
     Cont))))).

defs (dijkstras Ver Ver2 Dist Edges Min Cont)
     (alt (ifl (is_empty Ver) Cont) 
          (extractMin Ver Ver2 Min 
          (unload2 Min (n\v\ tup2 n v) (nm\cm\ 
               (load (tup2 nm cm ) Dist 
               (openDef nm 
               (loop2 Edges (adj\d\k1\ 
                  (alt (unload1 Dist (v\ tup2 adj v) (c\
                           (load (tup2 adj c) Dist k1)))
                       (unload2 Ver2 (n\v\ tup2 n v) (adj\c\ 
                         (alt (ifa (leq c (d + cm)) (load (tup2 adj c) Ver2 k1)) 
                              (ifa (gr c (d + cm)) (load (tup2 adj (d + cm)) Ver2 k1))
                      )))))
                 (dijkstras Ver2 Ver Dist Edges Min Cont)))))))).


example "extractMin"
  (k\ (unload2 ver (n\v\ tup2 n v) (n\v\
            (load (tup2 n v) min 
            (loop2 ver (n1\v1\k1\ 
                (unload2 min (n\v\ tup2 n v) (nm\vm\ 
                   (alt (ifa (gr v1 nm) (load (tup2 nm vm) min 
                             (load (tup2 n1 v1) ver2 k1 ))) 
                        (ifa (leq v1 nm) (load (tup2 n1 v1) min 
                             (load (tup2 nm vm) ver2 k1 ))))))) k ))))).



example "dijkstras"
  (k\ (alt (ifl (is_empty ver) k) 
           (extractMin ver ver2 min 
           (unload2 min (n\v\ tup2 n v) (nm\cm\ 
                (load (tup2 nm cm ) dist 
                (openDef nm 
                (loop2 edges (n\d\k1\ 
                   (alt (unload2 dist (n\v\ tup2 n v) (adj\c\
                            (load (tup2 adj c) dist k1)))
                        (unload2 ver2 (n\v\ tup2 n v) (adj\c\ 
                          (alt (ifa (leq c (d + cm)) (load (tup2 adj
c) ver2 k1)) 
                               (ifa (gr c (d + cm)) (load (tup2 adj
(d + cm)) ver2 k1))
))))) k)))))))).
