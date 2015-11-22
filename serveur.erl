% Module serveur réalisé par Dylan Leroux dans le cadre du projet en L3-I
% pour le cours 'Introduction à l'algorithmique distribuée'.
% Ce module est le module de départ qui reçoit les données en entrées
% du problème, fait appel à deux processus (baby et giant) pour certains
% calculs et résout le problème à l'aide des données récoltés.
% Ce serveur utilise aussi le module calcul (par moi-même) et lists (standard).

-module(serveur).
-export([start/3, start/4, loop/4, displayDoubleList/1]).

start(Y, A, N) ->
  start(Y, A, N, 0).

start(Y, A, N, DEBUG) ->  
  io:format("~n~n~n~nRecherche de x pour  ~w = ~w^x mod ~w ~n~n",[Y,A,N]),

  %   Création des deux processus
  Baby  = spawn(baby,  start, [A,Y,N]), 
  Giant = spawn(giant, start, [A,N]),

  %   Lancement des calculs
  Baby  ! { self(), calcul},
  Giant ! { self(), calcul},
  %   Attente. False,false car les processus baby et giant n'ont pas finis leur traitements, il faut recuperer les données.
  %   De plus, les traitements commencent avec des listes vides à compléter
  [BL,GL] = loop(false,false,[],[]),

  if
    (DEBUG==1) ->
      io:format("Suites donnees par Baby et Giant~n"),
      displayDoubleList(BL),
      displayDoubleList(GL);
    true -> io:format("~nSuites recu.~n")
  end,

  %   Triages des tableaux en fonction des premiers elements de chaque sous-tableau
  BLSorted = lists:sort(BL),
  GLSorted = lists:sort(GL),
  if
    (DEBUG==1) ->
      io:format("Suites triees~n"),
      displayDoubleList(BLSorted),
      displayDoubleList(GLSorted);
    true ->
      io:format("Suites triees.~n")
  end,


  [[V,W],[Q,R]] = commonCouple:firstCommonCouple(BLSorted, GLSorted),
  if
    ([[V,W],[Q,R]]==[[novalue,novalue],[novalue,novalue]]) ->
      io:format("Pas de solutions.~n");
    true ->
      io:format("~nPremier couple en commun : ~n[ (~w,~w), (~w,~w) ]~n",[V, W, Q, R]),
      X = R - W,
      io:format("~nValeur de x = ~w - ~w = ~w~n",[R, W, X]),
      io:format("Solution : ~w = ~w^~w mod ~w ~n~n",[Y,A,X,N]),


      % Test pour vérifier si le X trouvé résout bien l'équation.
      Test = calcul:powermode(A,R-W,N),
      if
        (Test==Y) ->
          io:format("Equation resolu.~n");
        true -> io:format("")
      end
  end.




%   Boucle d'attente et de récupération des resultats
loop(BabyFinish,GiantFinish,BabyList,GiantList) ->
  if
    BabyFinish and GiantFinish ->  
      %   Baby et Giant ont fini leur traitements, retour des listes
      [BabyList,GiantList]; 
    true -> 
      %   Dans les autres cas, serveur a encore des données à  recevoir
      receive
        %   Reception de données depuis le processus Baby, ajout à  la liste correspondante
        {_, [resultatBaby,V,I]} -> loop(BabyFinish,GiantFinish,[[V,I]|BabyList],GiantList);

        %   Reception de données depuis le processus Giant, ajout à  la liste correspondante
        {_, [resultatGiant,Q,IS]} -> loop(BabyFinish,GiantFinish,BabyList,[[Q,IS]|GiantList]);

        %   Baby a terminé son traitement
        {_, exitBaby} -> loop(true,GiantFinish,BabyList,GiantList);

        %   Giant a terminé son traitement
        {_, exitGiant} -> loop(BabyFinish,true,BabyList,GiantList)
      end
  end.





%   Afficher un tableau d'éléments à deux entiers
displayDoubleList([]) -> io:format("~n");
displayDoubleList([[]]) -> io:format("[]~n");
displayDoubleList([[Head1,Head2]|Tail]) -> io:format("[~w,~w] ",[Head1,Head2]), displayDoubleList(Tail).




