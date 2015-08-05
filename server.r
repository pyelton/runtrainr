library(ggvis)
source("helpers.R")
load("./enspls_model_app_080215.RData")

function(input, output, session) {   
    datas <- read.csv("./data/times",
                      sep = " ")
    inputs <- reactive({
        inputs <-data.frame(input$ytd_runs,
                         input$X5K,
                         input$elev,
                         input$mnth_pace1, 
                         input$weight,
                         input$minp,
                         input$sex, 
                         input$ytd_miles)
    })
    output$time <- renderText({
        your_time = model(inputs())
        percentile <- ecdf(unlist(datas))
        percent <- 100 - round(percentile(your_time), 2)*100
        paste("Your time is ", your_time%/%60, ":", sprintf('%02d', your_time%%60), ", faster than ", 
              percent, "% of runners on Strava.", sep = '')
    })
    time1 <- reactive({
        
        your_time = model(inputs())
    })
    temp <- reactive({
        data_line <- data.frame(
            x_rng = c(time1(), time1()), 
            y_rng = c(0, 0.030)
        ) 
    })

    output$improved <- renderUI({
        if (input$improvebutton == 0)
            return()
        input$improvebutton
        new_time = isolate(round(improve(inputs()),0))
        original_time <- isolate(model(inputs()))
        str1 <- paste("Take ", isolate(original_time - new_time),
             "min off your time")
        str2 <- paste("Go on a 2 mi run at ", input$minp - 1 , " min/mi")
        HTML(paste(str1, str2, sep = '<br/><br/>'))
    })
    datas %>%
        ggvis(~x) %>%
        layer_densities(stroke := "lightblue", fill := "dodgerblue") %>%
        layer_paths(x = ~x_rng, y = ~ y_rng, 
                    stroke := "skyblue", data = temp, strokeWidth := 5) %>%
        add_axis("x", title = "Half marathon times (min)", 
                 ticks = FALSE, properties = axis_props(title = list(fontSize=24, fill = "white"))) %>%
        add_axis("y", title = "", ticks = FALSE) %>%
        bind_shiny("plot", "plot_ui")
}