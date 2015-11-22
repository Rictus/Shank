% Module calcul réalisé par Dylan Leroux dans le cadre du projet en L3-I
% pour le cours 'Introduction à l'algorithmique distribuée'.
% Ce module a pour but le calcul et la manipulation de grands nombres,
% En particulier pour le calcul de  b^e mod m  avec des entiers à plus de 6 chiffres.


-module(calcul).
-export([pow/2,powermode/3]).

% Calcul de Base^Exponent
pow(Base,Exponent) ->
  if
    (Exponent==0) ->
      1;
    (Exponent rem 2 == 0) ->
      M = pow(Base,Exponent/2),
      M*M;
    true -> Base * pow(Base,Exponent-1) 
  end.


% Calcul de  (Base^Exponent) % Modulo
powermode(Base, Exponent, Modulo) ->
  if
    (Modulo==1) ->
      0;
    (Exponent==0) ->
      1;
    (Exponent==1) ->
      Base rem Modulo;

    true ->
      %M = round(Exponent/2),
      M = trunc(Exponent / 2), 
      if (2*M<Exponent) ->
          TMPR = powermode(Base, M, Modulo),
          (((TMPR * TMPR) rem Modulo) * (Base rem Modulo)) rem Modulo;
        true -> 
          TMPR = powermode(Base, M, Modulo),
          (TMPR * TMPR) rem Modulo
      end
  end.

