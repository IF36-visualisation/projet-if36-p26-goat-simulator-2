library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(readr)
library(scales)

# =========================
# DATA LOAD
# =========================
path <- "./data"

clubs <- read_csv(file.path(path, "clubs.csv"))
games <- read_csv(file.path(path, "games.csv"))
players <- read_csv(file.path(path, "players.csv"))
game_events <- read_csv(file.path(path, "game_events.csv"))
game_lineups <- read_csv(file.path(path, "game_lineups.csv"))
player_valuations <- read_csv(file.path(path, "player_valuations.csv"))
appearances <- read_csv(file.path(path, "appearances.csv")) 

# Conversion des dates indispensable pour les filtres
games$date <- as.Date(games$date)
player_valuations$date <- as.Date(player_valuations$date)
appearances$date <- as.Date(appearances$date) 

theme_football <- theme_minimal() +
  theme(
    plot.title = element_text(size = 15, face = "bold", hjust = 0.5),
    axis.title = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )

server <- function(input, output, session) {
  
  # =========================
  # Recuperation des valeurs de la sidebar et filtrage en fonction
  # =========================
  observe({
    updateDateRangeInput(
      session, "date_match",
      start = min(games$date, na.rm = TRUE),
      end = max(games$date, na.rm = TRUE),
      min = min(games$date, na.rm = TRUE),
      max = max(games$date, na.rm = TRUE)
    )
  })
  
  observe({
    req(input$date_match)
    competitions_autorisees <- c("FR1", "ES1", "GB1", "IT1", "BRA1", "NL1", "CL", "L1", "PO1", "BE1")
    
    comp <- games %>%
      filter( date >= input$date_match[1] & date <= input$date_match[2] & competition_id %in% competitions_autorisees) %>% pull(competition_id) %>%unique()
    updateSelectInput(session, "competition", choices = sort(comp))
  })
  
  observe({
    req(input$competition)
    clubs_list <- games %>% filter(competition_id == input$competition)
    noms <- unique(c(clubs_list$home_club_name, clubs_list$away_club_name))
    updateSelectInput(session, "club", choices = sort(noms))
  })
  
  observe({
    req(input$club)
    joueurs <- players %>% filter(current_club_name == input$club)
    updateSelectInput(session, "joueur", choices = joueurs$name)
  })
  
  # ========================================================
  # AUTO-SÉLECTION INITIALE
  # ========================================================
  observe({
    req(input$competition)
    clubs_list <- games %>% filter(competition_id == input$competition)
    noms <- sort(unique(c(clubs_list$home_club_name, clubs_list$away_club_name)))
    if(length(noms) > 0 && !(input$club %in% noms)) {
      updateSelectInput(session, "club", choices = noms, selected = noms[1])
    }
  })
  
  observe({
    req(input$club)
    joueurs <- players %>% filter(current_club_name == input$club) %>% pull(name) %>% sort()
    if(length(joueurs) > 0 && !(input$joueur %in% joueurs)) {
      updateSelectInput(session, "joueur", choices = joueurs, selected = joueurs[1])
    }
  })
  
  # =========================
  # Filtrage des données
  # =========================

  games_filtered <- reactive({
    req(input$date_match)
    
    competitions_autorisees <- c("FR1", "ES1", "GB1", "IT1", "BRA1", "NL1", "CL", "L1", "PO1", "BE1")
    
    games %>% 
      filter(
        date >= input$date_match[1] & 
          date <= input$date_match[2] &
          competition_id %in% competitions_autorisees 
      )
  })

  output$nb_matchs <- renderValueBox({
    valueBox(nrow(games_filtered()), "Matchs", icon = icon("futbol"), color = "blue")
  })
  
  output$nb_buts <- renderValueBox({
    buts <- sum(games_filtered()$home_club_goals + games_filtered()$away_club_goals, na.rm = TRUE)
    valueBox(buts, "Buts", icon = icon("bullseye"), color = "green")
  })
  
  output$nb_joueurs <- renderValueBox({
    valueBox(n_distinct(players$player_id), "Joueurs", icon = icon("users"), color = "yellow")
  })
  
  output$competitions_plot <- renderPlot({
    data <- games_filtered() %>% count(competition_id)
    data %>% ggplot( aes ( reorder ( competition_id, n), n)) +
      geom_col(fill = "#1F78B4") + coord_flip() + labs(title = "Matchs par compétition", x = "", y = "") + theme_football
  })
  
  output$goals_plot <- renderPlot({
    data <- games_filtered() %>%
      group_by(competition_id) %>%
      summarise(goals = sum(home_club_goals + away_club_goals, na.rm = TRUE))
    data %>% ggplot( aes( reorder( competition_id, goals), goals)) +
      geom_col(fill = "#2E8B57") + coord_flip() + labs(title = "Buts par compétition", x = "", y = "") + theme_football
  })
  
  
  # ========================================================
  # COMPETITIONS
  # ========================================================

  #valueBox pour affichage du nom réel de la compétition
  
  output$comp_nom <- renderValueBox({
    req(input$competition)
    noms_comp <- c("FR1"="Ligue 1", "ES1"="LaLiga", "GB1"="Premier League", "IT1"="Serie A", 
                   "BRA1"="Série A (Brésil)", "NL1"="Eredivisie", "CL"="Champions League", 
                   "DFL"="DFB-Pokal", "PO1"="Liga Portugal", "BE1"="Jupiler Pro League")
    nom <- if(input$competition %in% names(noms_comp)) noms_comp[input$competition] else input$competition
    
    valueBox(value = nom, subtitle = "Compétition Sélectionnée", icon = icon("trophy"), color = "black")
  })
  
  #valueBox pour affichage du pays qui organise/où à lieu la compétition
  
  output$comp_pays <- renderValueBox({
    req(input$competition)
    pays_comp <- c("FR1"="France", "ES1"="Espagne", "GB1"="Angleterre", "IT1"="Italie", 
                   "BRA1"="Brésil", "NL1"="Pays-Bas", "CL"="Europe (UEFA)", 
                   "DFL"="Allemagne", "PO1"="Portugal", "BE1"="Belgique")
    pays <- if(input$competition %in% names(pays_comp)) pays_comp[input$competition] else "International"
      
    valueBox(value = pays, subtitle = "Pays Organisateur / Zone", icon = icon("earth-europe"), color = "maroon")
  })
  
  #filtrage des données d'apparition sur cette compétition pour leur traitement
  
  apps_comp_all <- reactive({
    req(input$competition)

    ids_matchs <- games %>% filter(competition_id == input$competition) %>% pull(game_id)

    appearances %>% filter(game_id %in% ids_matchs)
  })
  
  apps_comp_filtered <- reactive({
    req(input$date_match)
    apps_comp_all() %>% filter(date >= input$date_match[1] & date <= input$date_match[2])
  })
  
  #tableau des meilleurs buteur de la periode choisie sur cette compétition
  
  output$comp_buteurs_periode <- renderTable({
    apps_comp_filtered() %>%
      group_by(player_name) %>%
      summarise(Buts = as.integer(sum(goals, na.rm = TRUE))) %>% 
      arrange(desc(Buts)) %>%
      head(5)
  })
  
  #tableau des meilleurs passeurs de la periode choisie sur cette compétition
  
  output$comp_passeurs_periode <- renderTable({
    apps_comp_filtered() %>%
      group_by(player_name) %>%
      summarise(Passes = as.integer(sum(assists, na.rm = TRUE))) %>% 
      arrange(desc(Passes)) %>%
      head(5)
  })
  
  #tableau des meilleurs buteur all time sur cette compétition
  
  output$comp_buteurs_alltime <- renderTable({
    apps_comp_all() %>%
      group_by(player_name) %>%
      summarise(Buts = as.integer(sum(goals, na.rm = TRUE))) %>% 
      arrange(desc(Buts)) %>%
      head(5)
  })
  
  #tableau des meilleurs passeurs all time sur cette compétition
  
  output$comp_passeurs_alltime <- renderTable({
    apps_comp_all() %>%
      group_by(player_name) %>%
      summarise(Passes = as.integer(sum(assists, na.rm = TRUE))) %>% 
      arrange(desc(Passes)) %>%
      head(5)
  })
  

  # graphique qui représente les clubs avec le plus de valeur marchande d'effectif de la compétition 

  output$comp_clubs_plot <- renderPlot({
    req(input$competition)
    
    clubs_de_la_comp <- games %>%
      filter(competition_id == input$competition) %>%
      select(home_club_name, away_club_name) %>%
      tidyr::pivot_longer(cols = everything(), values_to = "club_name") %>%
      pull(club_name) %>%
      unique()
    

    valeur_clubs_comp <- players %>%
      filter(current_club_name %in% clubs_de_la_comp) %>%
      filter(!is.na(market_value_in_eur)) %>%
      group_by(current_club_name) %>%
      summarise(valeur_calculee = sum(market_value_in_eur, na.rm = TRUE)) %>%
      arrange(desc(valeur_calculee))
    
  
    noms_comp <- c("FR1"="Ligue 1", "ES1"="LaLiga", "GB1"="Premier League", "IT1"="Serie A", 
                   "BRA1"="Série A (Brésil)", "NL1"="Eredivisie", "CL"="Champions League", 
                   "DFL"="DFB-Pokal", "PO1"="Liga Portugal", "BE1"="Jupiler Pro League")
    nom_titre <- if(input$competition %in% names(noms_comp)) noms_comp[input$competition] else input$competition

    
    valeur_clubs_comp %>% ggplot(aes(reorder(current_club_name, valeur_calculee), valeur_calculee)) +
      geom_col(fill = "#1F78B4") +
      coord_flip() +
      scale_y_continuous(labels = label_number(scale = 1e-6, suffix = " M€")) +
      labs(title = paste("Valorisation des clubs -", nom_titre), x = "", y = "") + 
      theme_football
  })
  
  # =========================
  # CLUB
  # =========================

  #value box pour l'affichage de la valeur marchande totale de l'effectif (on la recalcule car celle déjà implémenté dans le csv n'est pas complète)
  
  output$club_market_value <- renderValueBox({
    req(input$club)
    
    # On filtre les joueurs du club sélectionné et on somme leur valeur
    valeur_totale <- players %>% 
      filter(current_club_name == input$club) %>% 
      summarise(total = sum(market_value_in_eur, na.rm = TRUE)) %>% 
      pull(total)
    
    valeur_affiche <- if(is.na(valeur_totale) || valeur_totale == 0) {
      "0 M€"
    } else {
      paste0(round(valeur_totale / 1e6, 1), " M€")
    }
    valueBox(
      value = valeur_affiche,
      subtitle = "Valeur marchande (Cumul des joueurs)",
      icon = icon("euro-sign"),
      color = "green"
    )
  })
  
  #value box pour l'affichage de l'age moyen de l'effectif
  
  output$club_average_age <- renderValueBox({
    req(input$club)
    c <- clubs %>% filter(name == input$club)
    valueBox(round(c$average_age, 1), "Âge moyen", icon = icon("user"), color = "yellow")
  })
  
  #value box pour l'affichage du nom du club 
  
  output$club_name <- renderValueBox({
    req(input$club)
    valueBox(value = input$club, subtitle = "Nom du club", color = "black")
  })
  
  #value box pour l'affichage du nom du stade
  
  output$club_stade <- renderValueBox({
    req(input$club)
    c <- clubs %>% filter(name == input$club) %>% slice(1)
    nom_stade <- if(is.na(c$stadium_name) || c$stadium_name == "") "Non renseigné" else c$stadium_name

    valueBox(value = nom_stade, subtitle = "Stade", icon = icon("building"),color = "fuchsia")
  })
  
  #value box pour le nombre de joueur pro dans l'effectif du club
  
  output$club_nb_joueur <- renderValueBox({
    req(input$club)
    c <- clubs %>% filter(name == input$club)
    valueBox(c$squad_size, "Nombre de joueur pro", color = "lime")
  })
  
  #value box pour le pourcentage de joueur étranger dans l'effectif pro du club
  
  output$club_etranger <- renderValueBox({
    req(input$club)
    c <- clubs %>% filter(name == input$club)
    valueBox(c$foreigners_percentage, "Pourcentage de joueur étranger", icon = icon("percent"), color = "blue")
  })
  
  #value box pour le nombre de joueurs inténationaux (qui ont une séléction en équipe nationale) dans une équipe
  
  output$club_internationaux <- renderValueBox({
    req(input$club)
    c <- clubs %>% filter(name == input$club)
    valueBox(c$national_team_players, "Nombre de joueur internationaux", icon = icon("earth-europe"), color = "maroon")
  })
  
  #value box pour le top scorer de l'équipe
  
  output$club_top_scorer <- renderValueBox({
    req(input$club)
    
    id_club <- players %>% 
      filter(current_club_name == input$club) %>% 
      pull(current_club_id) %>% 
      unique()
    
    top_buteur <- appearances %>%
      filter(player_current_club_id %in% id_club) %>%
      group_by(player_name) %>%
      summarise(total_buts = as.integer(sum(goals, na.rm = TRUE))) %>%
      arrange(desc(total_buts)) %>%
      slice(1)

    texte_affichage <- paste0(top_buteur$player_name, " ", top_buteur$total_buts)
    
    valueBox(
      value = texte_affichage,
      subtitle = "Meilleur buteur de l'histoire du club (toutes saisons confondues)",
      icon = icon("crown"),
      color = "orange" 
    )
  })
  
  #barchart pour mêtre en avant les 15 joueurs ayant le plus de valeur marchande par clubs
  
  output$top10_clubs_plot <- renderPlot({
    req(input$club)
    
    top10_joueurs_club <- players %>%
      filter(current_club_name == input$club) %>%
      filter(!is.na(market_value_in_eur)) %>%
      arrange(desc(market_value_in_eur)) %>%
      slice(1:15) 
    
    req(nrow(top10_joueurs_club) > 0)
    
    ggplot(top10_joueurs_club, aes(reorder(name, market_value_in_eur), market_value_in_eur)) +
      geom_col(fill = "#006D2C") + 
      coord_flip() +
      scale_y_continuous(labels = label_number(scale = 1e-6, suffix = " M€")) +
      labs(
        title = paste("Top 15 des joueurs les plus valorisés du club", input$club), 
        x = "", 
        y = "Valeur marchande"
      ) + 
      theme_football
  })
  
 
  
  # =========================
  # PLAYER
  # =========================
  
  #filtres sur les players 
  
  player_apps_all <- reactive({
    req(input$joueur)
    pid <- players %>% filter(name == input$joueur) %>% pull(player_id)
    appearances %>% filter(player_id == pid)
  })
  
  player_apps_filtered <- reactive({
    req(input$date_match)
    player_apps_all() %>% 
      filter(date >= input$date_match[1] & date <= input$date_match[2])
  })
  
  #valuebox pour l'affichage du poste du joueur.
  
  output$box_poste <- renderValueBox({
    req(input$joueur)
    p_info <- players %>% filter(name == input$joueur) %>% slice(1)
    valueBox(p_info$sub_position, "Poste", icon = icon("user"), color = "blue")
  })
  
  #valuebox pour l'affichage de la valeur marchande actuelle du joueur
  
  output$box_valeur <- renderValueBox({
    req(input$joueur)
    p_info <- players %>% filter(name == input$joueur) %>% slice(1)
    valueBox(paste0(round(p_info$market_value_in_eur / 1e6, 1), " M€"), "Valeur Marchande", icon = icon("euro-sign"), color = "green")
  })
  
  #valuebox pour l'affichage du pied fort du joueur (cela peut etre les deux : BOTH)
  
  output$box_pied <- renderValueBox({
    req(input$joueur)
    p_info <- players %>% filter(name == input$joueur) %>% slice(1)
    valueBox(p_info$foot, "Pied Fort", icon = icon("shoe-prints"), color = "aqua")
  })
  
  #valuebox pour l'affichage du nom club actuel du joueur
  
  output$box_club <- renderValueBox({
    req(input$joueur)
    p_info <- players %>% filter(name == input$joueur) %>% slice(1)
    valueBox(p_info$current_club_name, "Club actuel", icon = icon("shield-halved"), color = "black")
  })
  
  #valuebox pour l'affichage de la nationalité sportive du joueur 
  
  output$box_nationalité<- renderValueBox({
    req(input$joueur)
    p_info <- players %>% filter(name == input$joueur) %>% slice(1)
    valueBox(p_info$country_of_citizenship, "Nationalité Sportive", icon = icon("flag"),color = "maroon")
  })
  
  #valuebox pour l'affichage du pays de naissance du joueur 
  
  output$box_pays_natal<- renderValueBox({
    req(input$joueur)
    p_info <- players %>% filter(name == input$joueur) %>% slice(1)
    valueBox(p_info$country_of_birth, "Pays de naissance", color = "lime")
  })
  
  #valuebox pour l'affichage de la date de naissance du joueur 
  
  output$box_date_naiss<- renderValueBox({
    req(input$joueur)
    p_info <- players %>% filter(name == input$joueur) %>% slice(1)
    valueBox(p_info$date_of_birth, "Date de naissance", icon = icon("cake"), color = "fuchsia")
  })
  
  #valuebox pour l'affichage du nombre de buts en carrière du joueur 
  
  output$box_buts_carriere <- renderValueBox({
    valueBox(sum(player_apps_all()$goals, na.rm = TRUE), "Buts en carrière", icon = icon("futbol"), color = "red")
  })
  
  #valuebox pour l'affichage du nombre de passe décisive en carrière du joueur 
  
  output$box_passes_carriere <- renderValueBox({
    valueBox(sum(player_apps_all()$assists, na.rm = TRUE), "Passes dé. en carrière", icon = icon("hands-helping"), color = "orange")
  })
  
  #valuebox pour l'affichage du nombre de buts sur la période du joueur
  
  output$box_buts_periode <- renderValueBox({
    valueBox(sum(player_apps_filtered()$goals, na.rm = TRUE), "Buts sur la période", icon = icon("circle-check"), color = "blue")
  })
  
  #valuebox pour l'affichage du nombre de passe décisive sur la période du joueur
  
  output$box_passes_periode <- renderValueBox({
    valueBox(sum(player_apps_filtered()$assists, na.rm = TRUE), "Passes dé. sur la période", icon = icon("share"), color = "light-blue")
  })
  
  #graphique représentant l'évolution de la valeur marchande du joueur.
  
  output$market_value_plot <- renderPlot({
    req(input$joueur)
    pid <- players %>% filter(name == input$joueur) %>% pull(player_id)
    vals <- player_valuations %>% filter(player_id == pid) %>% arrange(date)
    
    vals %>% ggplot(aes(x = date, y = market_value_in_eur)) +
      geom_line(aes(color = current_club_name, group = 1), linewidth = 1.2) +
      geom_point(aes(color = current_club_name), size = 2) +
      scale_y_continuous(labels = label_number(scale = 1e-6, suffix = " M€")) +
      labs(title = paste("Évolution de la valeur de", input$joueur), x = "", y = "", color = "Club") +
      theme_football + theme(legend.position = "bottom")
  })
  
}