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

server <- function(input, output) {
  population_trends_data <- reactive({
    new_data %>% 
      filter(country %in% input$country,
             year %in% c(input$year[1]:input$year[2]))
  })
  
  output$cum_co2<- renderPlotly({
    ggplotly(ggplot(population_trends_data(), 
                    aes(x=year, y=cumulative_co2, color = country)) + 
                                                     geom_line() + 
                                                     ggtitle("Cumulative Co2 Trends") +
                                                     labs(y = "Total Cumulative Carbon Dioxide Emission (Million Tonnes)")) 
  })
  
}
