library(shiny)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)
library(tidyr)

data <- read.csv("owid-co2-data.csv")

new_data <- data %>% 
  drop_na() %>% 
  select(year, country, cumulative_co2) %>% 
  as.data.frame()

#Takes input values from UI and filters data depending on input
server <- function(input, output) {
  co2_data <- reactive({
    new_data %>% 
      filter(country %in% input$country,
             year %in% c(input$year[1]:input$year[2]))
  })
  
#output of line plot with specific countries and chosen year range
  output$cum_co2<- renderPlotly({
    ggplotly(ggplot(co2_data(), 
                    aes(x=year, y=cumulative_co2)) + 
                    geom_line() + 
                    ggtitle("Cumulative Co2 Trends") +
                    labs(y = "Total Cumulative Carbon Dioxide Emission (Million Tonnes)")) 
  })
  
}
