# **Proposition**

## **Contexte**
Les données proviennent du site Transfermarkt, une plateforme de référence mondiale pour les statistiques de football, les transferts et les valeurs marchandes.
Téléchargeable [ici](https://www.kaggle.com/datasets/davidcariboo/player-scores?resource=download)  

ou  
```bash
   rm data/*
```
puis
```bash
   pip install kaggle
```
puis
```bash
   kaggle datasets download -d davidcariboo/player-scores --unzip -p ./data
```

Ce jeu de données a été créé pour offrir une base propre, structurée et régulièrement mise à jour (automatiquement via des scripts Python) pour l'analyse du football mondial. Il est utilisé par les data scientists pour la prédiction de valeurs marchandes, l'analyse de performance des joueurs ou le scouting.

Nous avons choisi ce dataset car nous voulions faire notre projet en rapport avec le sport. Après quelques recherches, nous avons trouvé ce dataset suffisamment riche pour le projet.

Les fichiers originaux sont trop volumineux pour être intégrés entièrement dans ce dépôt (plusieurs millions de lignes). Les fichiers présents ici sont donc des versions allégées, uniquement là pour donner un ordre d'idée de la structure des données (1000 lignes maximum).
Nous avons téléchargé les données le 30 mars 2026.
Le dataset source étant mis à jour toutes les semaines sur Kaggle, il est possible que les résultats diffèrent si vous utilisez une version plus récente que la nôtre.

## **Détails**  
Le dataset est divisé en 10 fichiers .csv dont voici le détail :   

-**appearances.csv** : Chaque ligne est une apparition d'un joueur dans un match (~1 850 000)  

>    appearance_id : identifiant de ligne pour le fichier ; Texte  
>    game_id : identifiant pour les parties ; Chiffre (Entier)  
>    player_id : identifiant pour les joueurs ; Chiffre (Entier)  
>    player_club_id : Identifiant du club pour lequel le joueur jouait au moment précis du match ; Chiffre (Entier)  
>    player_current_club_id : Identifiant du club où le joueur évolue actuellement ; Chiffre (Entier)  
>    date : Date exacte à laquelle le match a eu lieu ; Date(AAAA-MM-JJ)  
>    player_name : Nom complet du joueur ; Texte (Chaîne)  
>    competition_id : Identifiant de la compétition ; Texte (Code)  
>    yellow_cards : Nombre de cartons jaunes reçus durant la rencontre ; Chiffre (Entier)  
>    red_cards : Nombre de cartons rouges reçus durant la rencontre ; Chiffre (Entier)  
>    goals : Nombre de buts marqués par le joueur lors de ce match ; Chiffre (Entier)  
>    assists : Nombre de passes décisives délivrées ; Chiffre (Entier)  
>    minutes_played : Temps total passé sur le terrain ; Chiffre (Entier)  



-**players.csv** : profils de joueurs individuels (~38 000)

>    player_id : Identifiant unique du joueur ; Chiffre (Entier)  
>    first_name : Prénom du joueur ; Texte  
>    last_name : Nom de famille du joueur ; Texte  
>    name : Nom complet (maillot) ; Texte  
>    last_season : Dernière saison où le joueur a été actif ; Chiffre (Année)  
>    current_club_id : Identifiant du club actuel où évolue le joueur ; Chiffre (Entier)  
>    player_code : Identifiant textuel utilisé dans l'URL de Transfermarkt ; Texte  
>    country_of_birth : Pays de naissance du joueur ; Texte  
>    city_of_birth : Ville de naissance du joueur ; Texte  
>    country_of_citizenship : Nationalité sportive du joueur ; Texte  
>    date_of_birth : Date de naissance du joueur ; Date (AAAA-MM-JJ)  
>    sub_position : Poste précis ; Texte  
>    position : Catégorie de poste générale (Attaque, Milieu, Défense, Gardien) ; Texte  
>    foot : Pied principal ; Texte  
>    height_in_cm : Taille du joueur en centimètres ; Chiffre (Entier)  
>    contract_expiration_date : Date de fin du contrat actuel avec le club ; Date (AAAA-MM-JJ)  
>    agent_name : Nom de l'agent ou de l'agence qui gère le joueur ; Texte  
>    image_url : Lien vers la photo officielle du joueur sur Transfermarkt ; Texte  
>    international_caps : Nombre total de sélections en équipe nationale ; Chiffre   (Entier)
>    international_goals : Nombre total de buts marqués en équipe nationale ; Chiffre (Entier)  
>    current_national_team_id : Identifiant de l'équipe nationale actuelle du joueur ; Chiffre (Entier)  
>    url : Lien vers la fiche complète du joueur sur le site web ; Texte  
>    current_club_domestic_competition_id : Identifiant du championnat national du club actuel ; Texte (Code)  
>    current_club_name : Nom complet du club actuel ; Texte  
>    market_value_in_eur : Valeur marchande actuelle estimée en euros ; Chiffre (Décimal)  >    highest_market_value_in_eur : Valeur marchande la plus élevée atteinte dans la carrière ; Chiffre (Décimal)  



-**games.csv** : Détails sur les matchs (~82 000)

>    game_id : Identifiant unique de la rencontre ; Chiffre (Entier)  
>    competition_id : Identifiant de la compétition ; Texte (Code)  
>    season : Année de la saison concernée ; Chiffre (Année)  
>    round : Étape de la compétition ; Texte  
>    date : Date exacte du coup d'envoi ; Date (AAAA-MM-JJ)  
>    home_club_id : Identifiant du club recevant ; Chiffre (Entier)  
>    away_club_id : Identifiant du club visiteur ; Chiffre (Entier)  
>    home_club_goals : Nombre de buts marqués par l'équipe à domicile ; Chiffre (Entier)  
>    away_club_goals : Nombre de buts marqués par l'équipe à l'extérieur ; Chiffre (Entier)  
>    home_club_position : Classement du club à domicile avant le match ; Chiffre (Entier)  
>    away_club_position : Classement du club visiteur avant le match ; Chiffre (Entier)  
>    home_club_manager_name : Nom de l'entraîneur de l'équipe à domicile ; Texte  
>    away_club_manager_name : Nom de l'entraîneur de l'équipe à l'extérieur ; Texte  
>    stadium : Nom du stade où s'est déroulée la rencontre ; Texte  
>    attendance : Nombre de spectateurs présents dans le stade ; Chiffre (Entier)  
>    referee : Nom de l'arbitre principal de la rencontre ; Texte  
>    url : Lien direct vers le rapport de match sur Transfermarkt ; Texte (URL)  
>    home_club_formation : Système tactique de l'équipe à domicile ; Texte  
>    away_club_formation : Système tactique de l'équipe visiteuse ; Texte  
>    home_club_name : Nom complet du club à domicile ; Texte  
>    away_club_name : Nom complet du club visiteur ; Texte  
>    aggregate : Score cumulé (utilisé pour les matchs aller-retour) ; Texte  
>    competition_type : Type de tournoi ; Texte  



-**clubs.csv** : Regroupe les informations sur les clubs (~430)

>    club_id : Identifiant unique du club ; Chiffre (Entier)  
>    club_code : Nom court utilisé dans les URLs ; Texte  
>    name : Nom officiel complet du club ; Texte  
>    domestic_competition_id : Identifiant de la ligue nationale où évolue le club ; Texte (Code)  
>    total_market_value : Somme des valeurs marchandes de tous les joueurs de l'effectif ; Chiffre (Décimal)  
>    squad_size : Nombre total de joueurs sous contrat dans l'équipe première ; Chiffre (Entier)  
>    average_age : Âge moyen des joueurs de l'effectif ; Chiffre (Décimal)  
>    foreigners_number : Nombre de joueurs n'ayant pas la nationalité du pays du club ; Chiffre (Entier)  
>    foreigners_percentage : Pourcentage de joueurs étrangers dans l'effectif ; Chiffre (Pourcentage)  
>    national_team_players : Nombre de joueurs du club évoluant en équipe nationale ; Chiffre (Entier)  
>    stadium_name : Nom du stade principal du club ; Texte  
>    stadium_seats : Capacité totale (nombre de sièges) du stade ; Chiffre (Entier)  
>    net_transfer_record : Balance nette des transferts (Achats - Ventes) sur la période ; Texte/Chiffre  
>    coach_name : Nom de l'entraîneur actuel (ou dernier connu) ; Texte  
>    last_season : Dernière saison où le club est apparu dans les données ; Chiffre (Année)  
>    filename : Nom du fichier source interne au dataset ; Texte  
>    url : Lien vers la page du club sur le site Transfermarkt ; Texte (URL)  



-**player_valuations.csv** : Enregistrements historiques de valeurs marchandes (~520 000)

>    player_id : Identifiant unique du joueur ; Chiffre (Entier)  
>    date : Date à laquelle la valeur marchande a été mise à jour ou enregistrée ; Date (AAAA-MM-JJ)  
>    market_value_in_eur : Estimation de la valeur marchande du joueur à cette date précise ; Chiffre (Entier)  
>    current_club_name : Nom du club où le joueur évoluait lors de cette évaluation ; Texte  
>    current_club_id : Identifiant du club où le joueur évoluait lors de cette évaluation ; Chiffre (Entier)  
>    player_club_domestic_competition_id : Identifiant du championnat dans lequel le club évoluait à ce moment-là ; Texte (Code)  



-**competitions.csv** : Liste des championnats couverts (~50)

>    competition_id : Identifiant unique de la compétition ; Texte (Code)  
>    competition_code : Nom court utilisé dans l'URL ; Texte  
>    name : Nom complet de la compétition ; Texte  
>    sub_type : Sous-catégorie ; Texte  
>    type : Type général de compétition ; Texte  
>    country_id : Identifiant numérique du pays organisateur ; Chiffre (Entier)  
>    country_name : Nom du pays où se déroule la compétition ; Texte  
>    domestic_league_code : Code de la ligue nationale associée ; Texte (Code)  
>    confederation : Confédération continentale ; Texte  
>    url : Lien vers la page de la compétition sur Transfermarkt ; Texte (URL)  



-**club_games.csv** : Fait le lien entre les clubs et les matchs (~160 000)

>    game_id : Identifiant unique du match ; Chiffre (Entier)  
>    club_id : Identifiant du club dont on décrit la performance ; Chiffre (Entier)  
>    own_goals : Nombre de buts marqués par le club sujet lors du match ; Chiffre (Entier)  
>    own_position : Classement du club sujet en championnat avant le match ; Chiffre (Entier)  
>    own_manager_name : Nom de l'entraîneur du club sujet pour ce match ; Texte  
>    opponent_id : Identifiant du club adverse ; Chiffre (Entier)  
>    opponent_goals : Nombre de buts marqués par l'adversaire ; Chiffre (Entier)  
>    opponent_position : Classement de l'adversaire en championnat avant le match ; Chiffre (Entier)  
>    opponent_manager_name : Nom de l'entraîneur de l'équipe adverse ; Texte  
>    hosting : Indique si le club sujet jouait à domicile (Home) ou à l'extérieur (Away) ; Texte  
>    is_win : Résultat final pour le club sujet (1 pour victoire, 0 pour nul ou défaite) ; Chiffre (Binaire)  



-**game_events.csv** : Répertorie les événements marquants de chaque match (~1 150 000)

>    game_event_id : Identifiant unique de l'événement ; Texte  
>    date : Date du match où l'événement a eu lieu ; Date (AAAA-MM-JJ)  
>    game_id : Identifiant du match ; Chiffre (Entier)  
>    minute : Minute précise du match à laquelle l'action s'est produite ; Chiffre (Entier)  
>    type : Nature de l'action ; Texte (Catégorie)  
>    club_id : Identifiant du club qui a réalisé l'action ; Chiffre (Entier)  
>    club_name : Nom du club concerné par l'événement ; Texte  
>    player_id : Identifiant du joueur principal de l'action ; Chiffre (Entier)  
>    description :Détails textuels ; Texte  
>    player_in_id : Identifiant du joueur qui entre (remplacement) ; Chiffre (Entier)  
>    player_assist_id : Identifiant du joueur ayant fait la passe décisive ; Chiffre (Entier)  



-**game_lineups.csv** : Détaille qui était sur le terrain, sur le banc, ou dans le staff technique pour chaque match (~2 800 000)

>    game_lineups_id : Identifiant unique de la ligne ; Texte  
>    date : Date du match ; Date (AAAA-MM-JJ)  
>    game_id : Identifiant du match ; Chiffre (Entier)  
>    player_id : Identifiant du joueur présent sur la feuille de match ; Chiffre (Entier)  
>    club_id : Identifiant du club pour lequel le joueur est aligné ; Chiffre (Entier)  
>    player_name : Nom complet du joueur ; Texte  
>    type : Statut du joueur pour le match ; Texte  
>    position : Poste spécifique occupé durant ce match ; Texte  
>    number : Numéro de maillot porté par le joueur lors de cette rencontre ; Chiffre (Entier)  
>    team_captain : Indicateur précisant si le joueur était le capitaine de l'équipe ; Chiffre (Binaire)  

-**transfers.csv** : Suit les mouvements de joueurs entre les clubs  
>    player_id : Identifiant unique du joueur transféré ; Chiffre (Entier)  
>    transfer_date : Date exacte à laquelle le transfert a été enregistré ; Date (AAAA-MM-JJ)  
>    transfer_season : Saison au cours de laquelle le transfert a eu lieu ; Texte  
>    from_club_id : Identifiant du club qui vend ou libère le joueur ; Chiffre (Entier)  
>    to_club_id : Identifiant du club qui achète ou accueille le joueur ; Chiffre (Entier)  
>    from_club_name : Nom du club de départ ; Texte  
>    to_club_name : Nom du club d'arrivée ; Texte  
>    transfer_fee : Montant de la transaction ; Chiffre (Décimal)  
>    market_value_in_eur : Valeur marchande estimée du joueur au moment du transfert ; Chiffre (Décimal)  
>    player_name : Nom complet du joueur au moment de la transaction ; Texte  


## **Analyses possibles**
**1. L'efficacité offensive : Buts vs Passes décisives**  
Quels sont les joueurs qui contribuent le plus au score (buteurs vs passeurs) ?

Variables : goals et assists (de appearances.csv).

Graphique : Nuage de points (Scatter Plot).

-> Permet d'identifier des profils (le finisseur pur en haut à gauche, le meneur de jeu en bas à droite, la star complète en haut à droite).

**2. L'impact de l'âge sur le temps de jeu**  
À quel âge un joueur de football atteint-il son pic de présence sur le terrain ?

Variables : age (calculé via date_of_birth de players.csv) et minutes_played (appearances.csv).

Graphique : Line Chart (moyenne) ou Boxplot par tranche d'âge.

-> Idéal pour visualiser le déclin physique ou l'émergence des jeunes talents.

**3. Discipline et agressivité par championnat**  
 Existe-t-il des championnats plus "rugueux" que d'autres ?

Variables : yellow_cards, red_cards (appearances.csv) et competition_id (competitions.csv).

Graphique : Bar Chart empilé (Stacked Bar Chart).

-> Permet de comparer la moyenne de cartons par match entre la Ligue 1, la Premier League, etc.

**4. Corrélation entre Valeur Marchande et Performance**  
Le prix d'un joueur reflète-t-il statistiquement ses statistiques (buts/passes) ?

Variables : market_value_in_eur (players.csv) et goals + assists cumulés.

Graphique : Scatter Plot avec droite de régression.

-> Montre si le marché est rationnel ou s'il y a des "sur-cotations".

**5. Évolution historique des prix des transferts**  
Comment l'inflation a-t-elle impacté le marché du football sur les 10 dernières années ?

Variables : transfer_fee et transfer_season (transfers.csv).

Graphique : Line Chart (Histogramme temporel).

-> Visualise la croissance exponentielle des investissements dans le foot.

**6. Balance commerciale des clubs (Achats vs Ventes)**  
Quels clubs sont les plus profitables sur le marché des transferts ?

Variables : from_club_id, to_club_id et transfer_fee (transfers.csv).

Graphique : Treemap ou Bar Chart (Net Spend).

-> Identifie les "clubs formateurs" qui vendent cher et les "clubs acheteurs".


**7. Domination à domicile vs Extérieur**  
L'avantage du terrain est-il un mythe ou une réalité statistique ?

Variables : hosting et is_win (club_games.csv).

Graphique : Pie Chart ou Donut Chart comparatif.

-> Simple et efficace pour démontrer une tendance globale.

**8. Analyse des systèmes tactiques les plus victorieux**  
Quelles formations (4-3-3, 4-4-2, etc.) obtiennent le meilleur taux de victoire ?

Variables : home_club_formation (games.csv) et le résultat final.

Graphique : Heatmap ou Grouped Bar Chart.

-> Permet de voir si la mode tactique actuelle correspond à une efficacité réelle.

**9. Répartition des nationalités dans les grands championnats**  
Quelle est la proportion de joueurs étrangers dans les ligues majeures ?

Variables : country_of_citizenship (players.csv) et competition_id.

Graphique : Carte de chaleur (Choropleth Map) ou Histogramme circulaire.

->Montre l'attractivité des championnats européens à l'échelle mondiale.

**10. Relation entre Taille (Hauteur) et Position sur le terrain**  
La morphologie est-elle encore un critère déterminant pour certains postes ?

Variables : height_in_cm et position (players.csv).

Graphique : Boxplot (Boîte à moustaches).

->Montre la distribution (ex: les gardiens sont-ils statistiquement tous plus grands que les attaquants ?).

**11. Analyse des moments les plus cruciaux au sein d'un match**
Y a-t-il des tranches horaires où les buts et événements décisifs sont statistiquement plus fréquents ?

Variables : minute et type (de game_events.csv).

Graphique : Histogramme par tranche de 10 minutes (0–90+).

-> Montre si le football se joue davantage en fin de match et à quels moments les équipes sont les plus vulnérables.

**12. Recherche d'une relation entre pays d'origine et poste sur le terrain**
La nationalité d'un joueur est-elle statistiquement liée au poste qu'il occupe sur le terrain ?

Variables : country_of_citizenship et position (de players.csv), filtré sur les joueurs actifs dans les 5 grands championnats.

Graphique : Heatmap pays × poste (normalisée par effectif total par pays).

-> Révèle les spécificités culturelles et tactiques de chaque nation dans sa façon de former et de produire des joueurs.

**13. Étude de l'impact des grandes affluence sur les résultats d'une équipe**
Les clubs jouant devant de grandes foules obtiennent-ils de meilleurs résultats ?

Variables : attendance (de games.csv) croisé avec home_club_goals et away_club_goals.

Graphique : Scatter Plot avec droite de tendance, segmenté par championnat.

-> Permet de quantifier l'effet du "douzième homme" à partir des données réelles.

**14. L'impact des agents sur la valeur marchande d'un joueur ?**
Existe-t-il un écart significatif de valeur marchande entre les joueurs représentés et ceux sans agent déclaré ?

Variables : agent_name et market_value_in_eur (de players.csv).

Graphique : Boxplot comparatif (avec agent / sans agent) par poste.

-> Interroge le rôle de la représentation dans la valorisation marchande d'un joueur.

**15. Identification des clubs performants pour faire évoluer leurs joueurs**
Quels clubs créent le plus de valeur sur leurs joueurs formés ?

Variables : market_value_in_eur et date (de player_valuations.csv) croisés avec from_club_name et to_club_name (de transfers.csv).

Graphique : Bar Chart horizontal

-> Permet d'identifier les clubs formateurs qui créent de la valeur, au-delà de la simple balance financière des transferts.


