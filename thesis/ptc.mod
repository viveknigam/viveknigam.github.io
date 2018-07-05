module ptc.

member X [X|_].
member X [_|Y] :- member X Y.

of GammaA GammaL (abs R) (arr T1 T2) :- pi X\ of ((pa (var X) T1) :: GammaA) GammaL (R (var X)) T2.

of GammaA GammaL (app M N) T :- of GammaA GammaL M (arr T1 T), 
				of GammaA GammaL N T1.

of GammaA GammaL (let M N) T :- pi X\ (of GammaA ((pl (var X) M) :: GammaL) (var X) T1,
				of GammaA ((pl (var X) M) :: GammaL)  (N (var X)) T).

of GammaA GammaL (var X) T :- member (pa (var X) T) GammaA.

of GammaA GammaL (var X) T :- member (pl (var X) M) GammaL, 
			of GammaA GammaL M T.


% example query --> 	of (X :: ((pa (var a) t1) :: nil)) (Y :: ((pl (var b) c) :: nil)) (abs (x\ x)) Z.