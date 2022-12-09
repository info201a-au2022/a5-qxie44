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
  
#output of line plot with specific countries and chosen year range
  output$cum_co2<- renderPlotly(return({
    ggplotly(ggplot(new_data %>% 
                      filter(country == input$country,
                             year == c(input$year[1]:input$year[2])), 
                    aes(x=year, y=cumulative_co2)) + 
                    geom_line() + 
                    labs(y ="Total Cumulative CO2 Emission (Million Tonnes)",
                         title = "Cumulative CO2 Emission Trends")) 
  })
  )
}
