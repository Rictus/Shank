
Programme permettant la r�solution de l'�quation suivante :
Y = A^X mod N   (pour Y, A et N donn�).


Vous pouvez compiler l'ensemble du projet avec la commande erlang suivante :
c(calcul), c(baby), c(giant), c(commonCouple), c(serveur).


Pour lancer l'algorithme, tapez la commande suivante  (Pour Y, A et N donn�) :

serveur:start(Y,A,N).


Il existe deux m�thodes pour lancer l'algorithme :
La premi�re est la m�thode classique, pour Y, A et N donn� :
serveur:start(Y,A,N).

La seconde est une m�thode un peu plus verbeuse qui affiche les listes avant et apr�s leurs tries.
Attention cependant, avec des grands nombres, ces listes prennent du temps (et de la place) � s'afficher. 
Utilisez ce mode avec parcimonie.
serveur:start(Y,A,N,1).


J'ai essay� d'optimiser les algorithmes au maximum.
Sur mon ordinateur (CPU de 1,80 � 2,40 GHz), j'ai r�ussi � obtenir ces performances :
- Nombres (A,Y et N) � 10 chiffres (temps d'execution de 1 seconde)
- 11 chiffres (temps d'execution de 7 secondes)
- 12 chiffres (temps d'execution de 24 secondes).
