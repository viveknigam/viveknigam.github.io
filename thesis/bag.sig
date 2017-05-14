sig bag.

kind pair type -> type -> type.
% type pair A -> B -> pair A B.

% type membNrest   A -> list A -> list A -> o.
% type empty       A -> list (pair A B) -> o.
 
type pair loc -> tup -> pair loc tup.

type membNrest   A -> list A -> list A -> o.
type empty       A -> list (pair A B) -> o.

kind loc type.   % names of locations

type printSize list A -> int -> o.

type announce    o -> o.
type spy         o -> o.

type  append    list A -> list A -> list A -> o.

type getDef     int -> list A -> o.

kind tup   type. % Terms denoting tups.
type tup1    int -> tup.
type tup2    int -> int -> tup.
type tup3    int -> int -> int -> tup.

kind conda type. % Tests for booleans.
type leq, lt, eq, gr, geq   int -> int -> conda.

kind condl type. % Test on locations
type is_empty     loc -> condl.

kind cont  type.    % continuations

type interp  cont -> list (pair loc tup)  -> list (pair loc tup) -> o.

type load      tup -> loc -> cont -> cont.
type unload1   loc -> (int -> tup) -> (int -> cont) -> cont.
type unload2   loc -> (int -> int -> tup) -> (int -> int -> cont) ->
cont.
type while     conda -> (cont -> cont) -> cont -> cont.
type loop1     loc -> (int -> cont -> cont) -> cont ->
cont.
type loop2     loc -> (int -> int -> cont ->
cont) -> cont -> cont.
type alt       cont -> cont -> cont.
type ifa       conda -> cont -> cont.
type ifl       condl -> cont -> cont.
type openDef   int -> cont -> cont.
type done      cont.

type example  string -> (cont -> cont) -> o.

type a, b, ver, ver2, aux, edges, min, dist       loc.

type success, failure  conda -> o.
type test    list (pair loc tup)  -> o.
type test2   A ->  list (pair loc tup)  -> o.

type defs    cont -> cont -> o.
type extractMin  loc -> loc -> loc -> cont -> cont.
type dijkstras  loc -> loc -> loc -> loc -> loc -> cont -> cont.