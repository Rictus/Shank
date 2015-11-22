% Module insertSort réalisé par Dylan Leroux dans le cadre du projet en L3-I
% pour le cours 'Introduction à l'algorithmique distribuée'.
%  Ce module permet de trier un tableau en utilisant le tri par insertion.
%  L'algorithme de tri est légèrement modifié pour pouvoir trier un tableau
%  selon le premier élément de chaque sous-tableau.
%  Exemple :
%  [ [6,0], [12,1], [5,2], [10,3] ]
%  sera trié comme ceci :
%  [ [5,2], [6,0], [10,3], [12,1] ]


%Ce module n'est maintenant plus du tout utilisé au profit de  lists:sort(liste), qui est standard est plus adapté.

-module(insertSort).
-export([insertion/1,insert/1,insert/2]).

insertion(L) -> lists:foldl(fun insert/2, [], L).

insert([]) -> [].

insert(X,[]) -> [X];

insert([],Y) -> Y;

insert(X= [X1,_], L= [[H1,_] | _]) when X1 =< H1 -> [X|L]; 

insert(X,[H|T]) -> [H|insert(X, T)].


