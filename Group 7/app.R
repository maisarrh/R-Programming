#A look at unemployment rate to help unemployed in selecting states that would fit them locationally and financially.
#Provides interactive charts to display unemployment rate sorted by states and years.
#Provide brief idea on anything related to jobs

library(shiny)
library(shinydashboard)
library(rlang)
library(ggplot2)

rate <- read.csv("Unemployment_Rate_Clean.csv")
colnames(rate) <- c("No","States","Year2017","Year2018","Year2019")
rate$No <- as.numeric(rate$No)
rate$States<- as.character(rate$States)
rate$Year2017 <- as.numeric(rate$Year2017)
rate$Year2018 <- as.numeric(rate$Year2018)
rate$Year2019 <- as.numeric(rate$Year2019)

#This is a dashboard that displays the Unemployment rate in Malaysia. The data is retrived from the official DOSM

ui <- dashboardPage(
  
  skin = "purple",
  dashboardHeader(title = "WhereToWork"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Extra", tabName = "extra", icon = icon("th")),
      menuItem("Documentation", tabName = "Documentation", icon = icon("th"))
    )
  ),
  dashboardBody(
    
    tabItems(
      
      # First tab content
      tabItem(tabName = "dashboard",
              fluidRow(
                
                box(
                  width = 3,
                  title = "Select a Plot Type:",
                  selectInput("plot.type","Plot Type:", 
                              choices=c("Column", "Dot Plot"),
                              selected = "Column"),
                ),
                
                box(
                  width = 3,
                  title = "Select a Year:",
                  selectInput("year", "Year:", 
                              choices=c("2017","2018","2019"),
                              selected = "2019"),
                ),
                
                box(
                  width = 3,
                  title = "Change the background color:",status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  radioButtons("radio", label ="Background Color:",
                               choices = c("Thistle","Light Steel Blue 2","Khaki"),
                               selected = "Light Steel Blue 2")),
                
                box(
                  width = 12,
                  title = "Results",
                  plotOutput("plot1", height = 350, width =1000 ),
                ),
                
                
                
              )
      ),
      
      # Second tab content
      tabItem(tabName = "extra",
              
              fluidRow(
                       column(8, align="center",offset = 2,
                              
                              h3(strong("How to calculate the unemployment rate?")),
                              box(
                              width = 12,
                              img(src = "https://cdn.educba.com/academy/wp-content/uploads/2019/07/Unemploy-ment-Rate-Formula-1.jpg", height = 200, width = 400),
                              ),
                              
                              box(
                                width = 12, 
                                title = "Job Sites", status = "primary", solidHeader = TRUE,
                                collapsible = TRUE,
                              
                              h4("Find job opportunities in these websites"),
              
                              h3(strong("1. LinkedIn")),
                              tags$img(src="https://pioneerresumes.com/wp-content/uploads/2020/07/past-applicants.gif", height=250 , width=500),
                              h5("LinkedIn is used for professional networking that includes employers posting jobs and job seekers posting their Curriculum Vitae."),
                              tagList("Website:", a("https://my.linkedin.com/", href="https://my.linkedin.com/")),
              
              h3(strong("2. Jobstreet")),
              tags$img(src="https://www.the-network.com/wp-content/uploads/browshot/jobstreet-malaysia.png", height=250 , width=500),
              h5("Started in 1997, JobStreet is currently the largest online employment company in Southesast Asia."),
              tagList("Website:", a("https://www.jobstreet.com.my/", href="https://www.jobstreet.com.my/")),
              
              h3(strong("3. Monster")),
              tags$img(src="https://cdn01.vulcanpost.com/wp-uploads/2017/01/monstermalaysia.com_.png", height=250 , width=500),
              h5("Looking for a job where you can work from the comfort of your own home? There are several job opportunities that offer
                a work-from-home set-up!"),
              tagList("Website:", a("https://www.monster.com.my/", href="https://www.monster.com.my/")),
              
              h3(strong("4. MauKerja")),
              tags$img(src="http://infojimat.com/wp-content/uploads/2021/02/4.png", height=250 , width=500),
              h5("An exciting solution that benefit both business owners and job seekers is provided by MauKerja."),
              tagList("Website:", a("https://www.maukerja.my/", href="https://www.maukerja.my/")),
              
              h3(strong("5. Wobb.my")),
              tags$img(src="https://assets.wobbjobs.com/images/faq/img2-a.jpg", height=250 , width=500),
              h5("Working On Bean Bags (Wobb) lists employers according to their companies, and job hunters are able to have a sneak peek of the 
              interior of the office and also a closer look at the people and working culture before sending in their applications."),
              tagList("Website:", a("https://my.wobbjobs.com/", href="https://my.wobbjobs.com/")),
                       ), #End box
              
              box(
                width = 12, 
                title = "Interview", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                img(src = "https://www.thebalancecareers.com/thmb/RFUaH4oaj1t0d_AHaggGJJBiIj8=/1500x1000/filters:no_upscale():max_bytes(150000):strip_icc()/top-interview-tips-2058577_FINAL-5b7339fb46e0fb0050b4b20d.png", height = 350, width = 500),
              ),
              
              box(
                width = 12, 
                title = "Resume vs CV", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                img(src = "https://resumegenius.com/wp-content/uploads/2020/06/CV-vs-Resume-Differences.png", height = 450, width = 600),
              ),
              
              box(
                width = 12, 
                title = "Resume", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                img(src = "https://trainerkart.com/wp-content/uploads/2018/06/DOs-and-Donts-of-Resume.png", height = 600, width = 400),
              ),
              
              box(
                width = 12, 
                title = "Curriculum Vitae (CV)", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                img(src = "https://www.careerexperts.co.uk/wp-content/uploads/2018/03/7-CV-improvememt-tips-info.jpg", height = 700, width = 400),
              ),
              
              
              
              
              
                       )
              )
      ),
      tabItem(tabName = "Documentation",
              #summary.Rmd
              hr(),
              
              fluidRow(
                column(8, offset = 2,
                       includeMarkdown(rmarkdown::render("summary.Rmd"))
                )
              ),
              
              hr()
              )
    )
  ),

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

shinyApp(ui, server)