library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  skin = "green",
  
  dashboardHeader(title = "Foot Dataviz"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Vue Générale", tabName = "overview", icon = icon("chart-line")),
      menuItem("Compétitions", tabName = "competitions", icon = icon("trophy")),
      menuItem("Clubs", tabName = "clubs", icon = icon("shield-halved")),
      menuItem("Joueurs", tabName = "players", icon = icon("user")),
      
      hr(),
      
      dateRangeInput(
        inputId = "date_match", 
        label = "Période étudiée",
        start = NULL, 
        end = NULL,
        format = "yyyy-mm-dd",
        language = "fr",
        separator = " à "
      ),
      selectInput("competition", "Compétition", choices = NULL),
      selectInput("club", "Club", choices = NULL),
      selectInput("joueur", "Joueur", choices = NULL)
    )
  ),
  
  dashboardBody(
    tabItems(
      # =======================
      # VUE GENERALE
      # =======================
      
      tabItem(
        tabName = "overview",
        fluidRow(
          valueBoxOutput("nb_matchs"),
          valueBoxOutput("nb_buts"),
          valueBoxOutput("nb_joueurs")
        ),
        fluidRow(
          box(width = 6, title = "Répartition des compétitions",
              plotOutput("competitions_plot", height = "350px")),
          box(width = 6, title = "Buts par compétition",
              plotOutput("goals_plot", height = "350px"))
        )
      ),
      # =======================
      # COMPETITIONS
      # =======================
      tabItem(
        tabName = "competitions",
        h4("Informations Générales", style = "margin-left: 15px; font-weight: bold;"),
        fluidRow(
          valueBoxOutput("comp_nom", width = 6),
          valueBoxOutput("comp_pays", width = 6)
        ),
        
        fluidRow(
          column(width = 6,
                 box(width = 12, title = "Meilleurs Buteurs All-Time", status = "danger", solidHeader = TRUE,
                     tableOutput("comp_buteurs_alltime")),
                 box(width = 12, title = "Meilleurs Passeurs All-Time", status = "warning", solidHeader = TRUE,
                     tableOutput("comp_passeurs_alltime"))
          ),
          column(width = 6,
                 box(width = 12, title = "Meilleurs Buteurs (Période)", status = "primary", solidHeader = TRUE,
                     tableOutput("comp_buteurs_periode")),
                 box(width = 12, title = "Meilleurs Passeurs (Période)", status = "info", solidHeader = TRUE,
                     tableOutput("comp_passeurs_periode"))
          )
        ),
        br(),

        fluidRow(
          box(width = 12, title = "Classement des clubs les plus valorisés de la compétition", status = "primary",
              plotOutput("comp_clubs_plot", height = "450px"))
        )
      ),
      # =======================
      # CLUBS
      # =======================
      tabItem(
        tabName = "clubs",
        fluidRow(
          column(width = 8,
                 valueBoxOutput("club_name", width = 12),
                 valueBoxOutput("club_stade", width = 12)
          ),

          column(width = 4,
                 valueBoxOutput("club_market_value", width = 12),
                 valueBoxOutput("club_average_age", width = 12)
          )
        ),
        br(), 
        fluidRow(
          box(width = 8, title = "Joueurs les plus valorisés de l'effectif", plotOutput("top10_clubs_plot", height = "450px")),
          valueBoxOutput("club_nb_joueur", width = 4),
          valueBoxOutput("club_internationaux", width = 4),
          valueBoxOutput("club_etranger", width = 4),
          valueBoxOutput("club_top_scorer", width = 4)
          )
      ),
      
      # =======================
      # PLAYERS 
      # =======================
      tabItem(
        tabName = "players",
        h4("Profil & Carrière Globale", style = "margin-left: 15px; font-weight: bold;"),
        fluidRow(
          valueBoxOutput("box_poste", width = 4),
          valueBoxOutput("box_club", width = 8),
          valueBoxOutput("box_valeur", width = 2),
          
          valueBoxOutput("box_pays_natal", width = 2),
          valueBoxOutput("box_nationalité", width = 3),
          valueBoxOutput("box_pied", width = 2),
          valueBoxOutput("box_date_naiss", width = 3)
          
        ),
        
        h4("Statistiques sur la période sélectionnée", style = "margin-left: 15px; font-weight: bold"),
        fluidRow(
          valueBoxOutput("box_buts_carriere", width = 3),
          valueBoxOutput("box_passes_carriere", width = 3),
          valueBoxOutput("box_buts_periode", width = 3),
          valueBoxOutput("box_passes_periode", width = 3)
        ),
        fluidRow(
          box(width = 12, title = "Évolution de la valeur marchande", plotOutput("market_value_plot", height = "450px"))
        )
      )
    )
  )
)