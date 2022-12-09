library(plotly)
library(markdown)
library(shiny)
library(tidyr)

introduction_page <-tabPanel(
  "Introduction",
  fluidPage(
    includeMarkdown("./a5intro.Rmd")
  )
)

data <- read.csv("owid-co2-data.csv")

new_data <- data %>% 
  drop_na() %>% 
  select(year, country, cumulative_co2) %>% 
  as.data.frame()

unique_country <- new_data %>% 
  distinct(country)

# value input
interactive <- tabPanel(
  "Interactive", 
  titlePanel("Countries Cummulative CO2 Output"), 
  sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "country", 
          label = "Select a Country", 
          choices = unique_country$country,
          selected = "Austria"
        ),
        
        sliderInput("year",
                    "Timeline",
                    min = 1990,
                    max = 2018,
                    value = c(1990, 2018),
                    sep = "")
        ),
        
      mainPanel(plotlyOutput("cum_co2"))
  ),
  print("Through this visualization, we can see how some countries produce darastically much more carbon dioxide than others looking
       at the scaling of each outry with the addition of continuous growth pattern for every country.")
)

#tab bar
ui <- navbarPage(
  "Assignment 5",
  introduction_page,
  interactive
)