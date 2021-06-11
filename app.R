library(shiny)
library(rlang)
library(ggplot2)

rate <- read.csv("Unemployment_Rate_Clean.csv")
colnames(rate) <- c("No","States","Year2017","Year2018","Year2019")
rate$No <- as.numeric(rate$No)
rate$States<- as.character(rate$States)
rate$Year2017 <- as.numeric(rate$Year2017)
rate$Year2018 <- as.numeric(rate$Year2018)
rate$Year2019 <- as.numeric(rate$Year2019)


ui <- fluidPage(
  
  titlePanel("Group 7 - Shiny App: WhereToWork"),
  
  sidebarLayout(
    
    sidebarPanel(
      
        selectInput("plot.type","Plot Type:",
                    choices=c("Column", "Dot Plot"),
                    selected = ""),
      
        selectInput("year", "Year:", 
                  choices=c("2017","2018","2019"),
                  selected = "2017"),
      
        radioButtons("radio", label ="Background Color:",
                   choices = c("Thistle","Light Steel Blue 2","Sea Green 1","Khaki", "Pink","Yellow"),
                   selected = "Light Steel Blue 2")),
    
    mainPanel(
        plotOutput("plot1")
        
      )
    
      )
  )
  


server <- function(input, output) {
  

  output$plot1 <- renderPlot({
      if (input$year == '2017') {
        i <- 3
        }
      if (input$year == '2018') {
        i <- 4
        } 
      if (input$year == '2019') {
        i <- 5
        } 
   
      y <-rate[,i] 
      
      if (input$plot.type == "Column") {
        ggplot(data= rate) +  geom_text(aes_string(x="States", y, label=y), vjust = -0.5) +
          geom_col(mapping=aes_string(x="States", y, fill="States"), show.legend=FALSE, col = input$radio) +
          labs(x="States", y="Unemployment Rate (%)") +
          ggtitle(paste("Column Plot: Unemployment Rate in Malaysia in", input$year)) +
          theme(axis.text.x = element_text(colour = "black", size = 6, face = "bold"),
                axis.text.y = element_text(colour = "black", size = 8, face = "bold"),
                axis.title.x = element_text(size = 15, face = "bold"), 
                axis.title.y = element_text(size = 15, face = "bold"), 
                plot.background = element_rect(fill = input$radio), 
                plot.title =  element_text(colour = "black", face = "bold", size = rel(2)))
      }else{
          ggplot(data = rate) +
          geom_dotplot(binwidth = 0.5, mapping = aes_string(x="States", y, fill="States"), show.legend=FALSE, 
                        col = input$radio, binaxis='y', stackdir='center',stackratio=1, dotsize=0.5) + coord_flip() + 
          labs(x="States", y = "Unemployment Rate (%)") + geom_text(aes_string(x="States", y, label=y)) +
          ggtitle(paste("Dot Plot: Unemployment Rate in Malaysia in", input$year)) +
          theme(axis.text.x = element_text(colour = "black", size = 10, face = "bold"),
                axis.text.y = element_text(colour = "black", size = 8, face = "bold"),
                axis.title.x = element_text(size = 15, face = "bold"), 
                axis.title.y = element_text(size = 15, face = "bold"), 
                plot.background = element_rect(fill = input$radio),
                plot.title =  element_text(colour = "black", face = "bold", size = rel(2))) 
                
      }
        })
}

shinyApp(ui= ui, server = server)