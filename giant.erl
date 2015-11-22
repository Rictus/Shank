% Module giant réalisé par Dylan Leroux dans le cadre du projet en L3-I
% pour le cours 'Introduction à l'algorithmique distribuée'.
% Ce module est lancé par le serveur et, à partir de A et N,
% permet de calculer une suite de couples ((A^(T*S) mod N),S) 
% avec T variant de 1 à S et S étant la racine carrée de N.

-module(giant).
-export([start/2,loop/2,calcul/4]).

start(A,N) ->
  loop(A,N).



loop(A,N)->
  receive
    { From, calcul } ->
      io:format("~nGiant : Debut des calculs"),
      calcul(A,N,1,From)
  end.



calcul(A,N,I,FROM) ->
  %Si i est entre 0 et S-1 :  Calcul a^(i*s)mod n et envoi du couple (resultat,i*s) FROM
  %Sinon, envoi du message de fin
  S = round(math:sqrt(N)),
  if
    (I>=1) and (I=<S) ->
      Q = round(calcul:powermode(A,I*S,N)),     % Q = A^(I*S) mod N
      FROM ! {self(), [resultatGiant,Q,I*S]},   
      calcul(A,N,I+1,FROM);
    true      ->io:format("~nGiant : Fin des calculs"), FROM ! {self(), exitGiant}
  end. 