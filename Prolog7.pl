%Name: Noah Bae
%Assignment: 13
%Date: 3.22.22

%Exercise 6.3
my_ground([]) :- !.
my_ground([Head|Tail]) :- 
   atomic(Head), !,
   my_ground(Tail).
   ;
   nonVar(Head), 
   Head = ..Tail, 
   my_ground(Tail).

%Exercise 6.7
my_copy_term(Term, Copy) :-
	asserta(Term),
	retract(Copy).

%Exercise 6.8
subset_with_backtracking([], []).
subset_with_backtracking([Head|Set], [Head|Subset]) :- 
   subset_with_backtracking(Set, Subset).
subset_with_backtracking(Set, [_|Subset]) :- 
   subset_with_backtracking(Set, Subset).

powerset(Set, Subsets) :- bagof(S, subs(S, Set), Subsets).















% count( A, L, N)
% N is the number of occurrences of
% atom A in list L.

count( _, [], 0).

count( A, [A|L], N) :- !,
   count( A, L, N1),
   N is N1 + 1.

count( A, [_|L], N) :-
   count( A, L, N).

% count2( A, L, N)
% Second version in case L has variables.

count2( _, [], 0).

count2( A, [B|L], N) :-
   atom( B), A = B, !,
   count2( A, L, N1),
   N is N1 + 1
   ;
   count2( A, L, N).

% Built-in univ operator, =..
% Term =.. [Functor | ArgumentList]
% [Functor | ArgumentList] is a list that contains the principle
% functor of Term, followed by its arguments.

% square( Side)
% triangle( Side1, Side2, Side3)
% circle( Radius)

% enlarge( Fig, Factor, Fig1)
% Fig1 is Fig with each argument multiplied by
% Factor. The arguments are already numbers.
% Test: ?- enlarge( square( 5), 2, Figure).
% Test: ?- enlarge( triangle( 3, 4, 5), 3, Figure).

enlarge( Fig, F, Fig1) :-
   Fig =.. [Type|Parameters],
   multiplylist( Parameters, F, Parameters1),
   Fig1 =.. [Type|Parameters1].

multiplylist( [], _, []).

multiplylist( [X|L], F, [X1|L1]) :-
   X1 is F * X,
   multiplylist( L, F, L1).

% Built-in predicate functor/3.
% functor( Term, Functor, Arity)
% Functor is the functor of Term and Arity is its arity.

% Built-in predicate arg/3.
% arg( N, Term, Argument)
% Argument is the Nth argument in Term,
% left to right starting with 1.

% count3( Term, List, N)
% Third version. N is the number of literal
% occurrences of Term in List.
% Test ?- count3(a, [a,b,X,Y,a], N).
% Test ?- count3(X, [a,b,X,Y,a], N).
% Test ?- count2(X, [a,b,X,Y,a], N).

count3( _, [], 0).

count3( Term, [Head|L], N) :-
   Term == Head, !,
   count3( Term, L, N1),
   N is N1 + 1
   ;
   count3( Term, L, N).

% Examples of assertz/1 and retract/1.
% Note the dynamic declaration not in Bratko.
% gprolog does not have assert/1.

nice :-
   sunshine, \+ raining.

funny :-
   sunshine, raining.

disgusting :-
   raining, fog.

:- dynamic( sunshine/0).
:- dynamic( raining/0).
:- dynamic( fog/0).

raining.
fog.

:- dynamic( fast/1).
:- dynamic( slow/1).

fast( ann).
slow( tom).
slow( pat).

% retract is non-deterministic.
% Test ?- assertz(( faster( X, Y) :- fast( X), slow( Y))).
% Test ?- faster( A, B).
% Test ?- retract( slow( X)).
% Test ?- faster( ann, _).

:- dynamic( p/1).

% asserta vs assertz
% Test ?- assertz( p(b)), assertz( p(c)).
% Test ?- assertz( p(d)), asserta( p(a)).
% Test ?- p( X).

my_product( X, Y, P) :-
   P is X * Y.

% Caching or "memoization" with assertz.

:- dynamic( product/3).

maketable :-
   L = [0,1,2,3,4,5,6,7,8,9],
   member( X, L),
   member( Y, L),
   Z is X * Y,
   assertz( product( X, Y, Z)),
   fail.

% Data for bagof tests:
age( peter, 7).
age( ann, 5).
age( pat, 8).
age( tom, 5).
age( henry, 5).
age( henry, 5).  % Another henry who is also 5

% bagof( X, P, L)
% L is a list of all the objects X
% such that goal P is satisfied.
% Test ?- bagof( Child, age( Child, 5), List).
% Test ?- bagof( Age, age( pat, Age), List).
% Test ?- bagof( Child, age( Child, Age), List).

% setof( X, P, L)
% L is a sorted list (set) of all the objects X
% such that goal P is satisfied.
% Test ?- bagof( Child, age( Child, 5), List).
% Test ?- setof( Child, age( Child, 5), List).

% cube( N, C)
% C is the cube of N

cube( N, C) :-
   C is N * N * N.

% cube/0
% An interactive program to prompt the user for the values to cube.

cube :-
   read( X),
   process( X).

process( stop) :- !.

process( N) :-
   C is N * N * N,
   write( C),
   put( 10),  % new line
   cube.

% cube2/0
% Erroneous attempt to simplify cube/0.

cube2 :-
   read( stop), !.

cube2 :-
   read( N),
   C is N * N * N,
   write( C),
   put( 10),  % new line
   cube2.

% cube3/0
% An interactive program to prompt the user for the values to cube.

cube3 :-
   write( 'Next item, please: '),
   read( X),
   process3( X).

process3( stop) :- !.

process3( N) :-
   C is N * N * N,
   write( 'Cube of '), write( N),
   write( ' is '), write( C), nl,
   cube3.

% writelist( L)
% Outputs each element of L on a separate line.
% One base case fact and one rule.

writelist( []).

writelist( [X|L]) :-
   write( X), nl,
   writelist( L).

% writelist2 ( LL)
% LL is a list of lists.
% Outputs the elements of each list of LL on a separate line.

writelist2( []).

writelist2( [L|LL]) :-
   doline( L), nl,
   writelist2( LL).

doline( []).

doline( [X|L]) :-
   write( X), tab( 1),
   doline( L).

% bars( L)
% L is a list of integers.
% Prints a row of N *'s for each number N in L.
% Ignore any negative values.

bars( []).

bars( [N|L]) :-
   stars( N), nl,
   bars( L).

stars( N) :-
   N > 0,
   write( *),
   N1 is N - 1,
   stars( N1).

stars( N) :-
   N =< 0.

% showfile( N)
% Print the terms in the current stream
% with consecutive numbers starting with N.
% Test: see( 'dog_data'). showfile( 0). seen.
% Test: see( 'gcd.pl'). showfile( 0). seen.

showfile( N) :-
   read( Term),
   show( Term, N).

show( end_of_file, _) :- !.

show( Term, N) :-
   write( N), tab( 2), write( Term), nl,
   N1 is N + 1,
   showfile( N1).

% get0( C)
% C is the next single character from the input stream.

% get( C)
% Same as get0, but skips nonprintable characters.

% squeeze
% Remove multiple blanks from the input stream.
% Terminate with period.
% Test: see( blanks). squeeze. seen.

squeeze :-
   get0( C),      % get0/1, so C might be ASCII blank
   put( C),
   dorest( C).

dorest( 46) :- !. % 46 is ASCII period.

dorest( 32) :- !, % 32 is ASCII blank.
   get( C),       % Skip leading blanks with feature of get/1.
   put( C),       % Output first nonblank character of a word.
   dorest( C).

dorest( _) :-
   squeeze.

% name( A, L)
% L is the list of ASCII codes of characters in A.

% taxi( X)
% Test whether an atom X has taxi prefix.
% A single rule with conc/3 using name/2.

taxi( X) :-
   name( X, Xlist),
   name( taxi, Tlist),
   conc( Tlist, _, Xlist).  % Is word 'taxi' prefix of X?

% conc( L1, L2, L3)
% L3 is the concatenation of L1 and L2.

conc( [], L, L).
conc( [X|L1], L2, [X|L3]) :-
   conc( L1, L2, L3).
