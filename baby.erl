% Module baby réalisé par Dylan Leroux dans le cadre du projet en L3-I
% pour le cours 'Introduction à l'algorithmique distribuée'.
% Ce module est lancé par le serveur et, à partir de A,Y et N,
% permet de calculer une suite de couples ((Y*A^(I) mod N), S-1) 
% avec I variant de 0 à S-1 et S étant la racine carrée de N.

-module(baby).
-export([start/3,loop/3,calcul/5]).

start(A,Y,N) ->
  loop(A,Y,N).



loop(A,Y,N)->
  receive
    { From, calcul } ->
      io:format("Baby  : Debut des calculs"),
      calcul(A,Y,N,0,From)
  end.



calcul(A,Y,N,I,FROM) ->
  %Si i est entre 0 et S-1 :  Calcul y*a^i mod n et envoi du couple (resultat, i) à FROM
  %Sinon, envoi du message de fin
  S = round(math:sqrt(N)),
  if
    (I>=0) and (I=<(S-1)) -> 
      V = (Y * calcul:powermode(A,I,N)) rem N,
      FROM ! {self(), [resultatBaby,V,I]},
      calcul(A,Y,N,I+1,FROM);
    true      ->io:format("~nBaby  : Fin des calculs"), FROM ! {self(), exitBaby}
  end. 