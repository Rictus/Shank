
Programme permettant la résolution de l'équation suivante :
Y = A^X mod N   (pour Y, A et N donné).


Vous pouvez compiler l'ensemble du projet avec la commande erlang suivante :
c(calcul), c(baby), c(giant), c(commonCouple), c(serveur).


Pour lancer l'algorithme, tapez la commande suivante  (Pour Y, A et N donné) :

serveur:start(Y,A,N).


Il existe deux méthodes pour lancer l'algorithme :
La première est la méthode classique, pour Y, A et N donné :
serveur:start(Y,A,N).

La seconde est une méthode un peu plus verbeuse qui affiche les listes avant et après leurs tries.
Attention cependant, avec des grands nombres, ces listes prennent du temps (et de la place) à s'afficher. 
Utilisez ce mode avec parcimonie.
serveur:start(Y,A,N,1).


J'ai essayé d'optimiser les algorithmes au maximum.
Sur mon ordinateur (CPU de 1,80 à 2,40 GHz), j'ai réussi à obtenir ces performances :
- Nombres (A,Y et N) à 10 chiffres (temps d'execution de 1 seconde)
- 11 chiffres (temps d'execution de 7 secondes)
- 12 chiffres (temps d'execution de 24 secondes).
