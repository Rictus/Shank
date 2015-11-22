% Module calcul réalisé par Dylan Leroux dans le cadre du projet en L3-I
% pour le cours 'Introduction à l'algorithmique distribuée'.
% Ce module retourne les deux sous-tableaux (à deux elements) commun aux deux tableaux donnés.
% Deux sous-tableaux sont considérés commun lorsque le premier élément de l'un est égal au premier élément de l'autre.
% Exemple : Soit deux tableaux :
% [ [5,2], [6,0], [10,3], [12,1] ]
% [ [2,16], [5,12], [9,8], [16,4] ]
% Le retour sera le couple  [ [5,2], [5,12] ] 

-module(commonCouple).
-export([firstCommonCouple/2,searchFirstCommonCouple/4]).

firstCommonCouple(Liste1, Liste2) ->
  if
    (length(Liste1)>=length(Liste2)) ->
      searchFirstCommonCouple(Liste1, Liste1, Liste2, Liste2);
    true ->
      searchFirstCommonCouple(Liste2, Liste2, Liste1, Liste1)
  end.


searchFirstCommonCouple(DebutListe1, [[X1,X2]|Tail1], DebutListe2, [[Y1,Y2]|Tail2]) ->
  %Pour chaque X1, on regarde s'il est présent dans la seconde liste
  if  
    (X1==Y1) -> 
      [[X1,X2],[Y1,Y2]];

    (Tail1==[]) ->
      % Arrivé à la fin de la liste 1
      % On recommence avec le prochain element de la liste 2 
      [[novalue,novalue],[novalue,novalue]];

    (X1<Y1) -> 
      % Les listes en entrées sont triées,
      % donc si X1 est plus petit que Y1,
      % On fait avancer le curseur de la première liste
      searchFirstCommonCouple(DebutListe1, Tail1, DebutListe2, [[Y1,Y2]|Tail2]);

    (Tail2==[]) -> 
      [[novalue,novalue],[novalue,novalue]];

    (X1>Y1) ->  
      % Les listes en entrées sont triées, 
      % donc si X1 est plus grand que Y1, 
      % On fait avancer le curseur de la seconde liste
      searchFirstCommonCouple(DebutListe1, [[X1,X2]|Tail1], DebutListe2, Tail2)
  end.
