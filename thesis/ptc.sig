sig	ptc.

kind	term	type.
kind	typ	type.
kind	pat	type.
kind	plt	type.

type 	a, b, c	term.
type	t1, t2	typ.

type	abs	(term -> term) -> term.
type	app	term -> term -> term.
type	let	term -> (term -> term) -> term.
type	var	term -> term.

type	pa	term -> typ -> pat.
type	pl	term -> term -> plt.

type	arr	typ -> typ -> typ.

type	member	A -> list A -> o.
type 	of	list pat -> list plt -> term -> typ -> o.


