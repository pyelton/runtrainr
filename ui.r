library(ggvis)
library(shiny)

fluidPage( tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "boostrap.css")),
    navbarPage("Runtrainr: Beat your half marathon time",
        tabPanel("About", 
            fluidRow(
                column(12,
                    br(),
                    h2("Predict and improve your half marathon time", align = "center"),
    		        br(),
                    br(),
                    h3("1. Input your training information, weight, and gender"
                                      , align = "center"),
    		        br(),
    		        br(),
                    h3("2. Then adjust your training plan to improve your time"
                                      , align = "center")))),
        tabPanel("App",
            sidebarLayout(
                sidebarPanel(
            	tags$head(    
            	    tags$style(type='text/css', ".irs-max { font-size: 0pt; }"),
                	    tags$style(type='text/css', ".irs-min { font-size: 0pt; }"),    
            	    tags$style(type='text/css', ".irs-bar { background: #33CCFF; border-color: #33CCFF }"),
            	    tags$style(type='text/css', ".irs-bar-edge { background: #33CCFF; border-color: #33CCFF }")),
            	        h3("Training information", align = "center"),
                    	br(),
                        br(),
                    sliderInput("minp", "Fastest pace > 2 mi (past month):",
                                min=5, max=18, post = " min/mi", step = 0.5,
                                value=10, ticks = FALSE),
                    sliderInput("mnth_pace1", "Average pace (past month):",
                                min = 5, max = 18, value = 10, step= 0.5, ticks = FALSE),
                    sliderInput("ytd_miles", "Mi/week (past six months):",
                                min = 0, max = 90, value = 10, ticks = FALSE),
                    sliderInput("ytd_runs", "Runs/wk (past 6 months):",
                                min = 0, max = 7, value = 3, step = 1,
                                ticks = FALSE),
                    sliderInput("elev", "Elevation change/wk (past month):",
                                min = 0, max = 10000, value = 1000, post = " ft",
                                step = 500, ticks = FALSE),
            	    sliderInput("X5K", "5K (3.1 mi) time:",
            	            min = 15, max = 50, value = 25, step = 1, ticks = FALSE),
            	    sliderInput("weight", "Weight (lbs):",
            	            min = 90, max = 250, value = 140, step = 1, ticks = FALSE)
                ),#sidebarPanel end
                mainPanel(
            	h3(textOutput("time"), align = "center"),
                    ggvisOutput("plot"),
                    tableOutput("mtc_table"),
                    fluidRow(
                        column(6,
                               wellPanel(
                                   radioButtons("sex", label = h5("Gender"),
                                                choices = list("Female" = 'F', "Male" = 'M'), 
                                                selected = 'F'))),
                        column(6,
                               wellPanel(      
                                   actionButton("improvebutton","Want to improve your time?"),
                                   tags$style(type='text/css', "#improvebutton { float: center; }"),
                                   h5(htmlOutput("improved"))))
                        )#fluidrow end
                    )  #mainPanel end
        )),
        tabPanel("Slides",
                 tags$iframe(src = "https://docs.google.com/presentation/embed?id=1QemHAqv_vbBhpe09lYs_7l-f0FlS8u2g2YXWrdvxcio&amp;start=false&amp;loop=false&amp;",
                             frameborder = "0",
                             width = "960",
                             height = "569",
                             allowfullscreen = TRUE,
                             mozallowfullscreen = TRUE,
                             webkitallowfullscreen = TRUE))#tabPanel end
))
