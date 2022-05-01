%Name: Noah Bae
%Assignment: 12
%Date: 3.22.22

%Exercise 3.11 Deterministic
your_flatten([Head2|Tail2], FlatList2) :-
	your_flatten(Head2,FlatHead2),
	your_flatten(Tail2,FlatTail2),
	conc(FlatHead2,FlatTail2,FlatList2),!.

your_flatten([],[]).
your_flatten(X2,[X2]).

%Exercise 5.2
class(Number, positive) :-
  Number > 0, !.
class(Number,negative) :-
  Number < 0, !.
class(_,zero).

%Exercise 5.5
set_difference([], _, []).
set_difference([Head|Tail], Set, Difference) :- 
   member(Head, Set), 
   !, 
   set_difference(Tail, Set, Difference).
set_difference([Head|Tail], Set, [Head|Difference]) :- 
   set_difference(Tail, Set, Difference).

%Exercise 5.6
unifiable([],_,[]).
unifiable([Head|Tail], Set, Rest) :- 
   not(Set = Head), 
   !, 
   unifiable(Tail,Set,Rest).
unifiable([Head|Tail], Set, [Head|Rest]) :- 
   unifiable(Tail,Set,Rest).
