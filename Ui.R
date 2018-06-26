library(shiny)

ui <- fluidPage( theme = "bootstrap.css", #Use bootstrap css
  
  shinyUI(navbarPage("Twitter Sentiment Analysis", #Main Navbar
                     
                     tabPanel("Analysis", #Analysis Tab
                        
                        #Designing sidebar components
                        sidebarPanel(helpText("When you enter related KEYWORDS, we can search Tweets through Twitter.")),
                        
                        #Designing mainPanel Components
                        mainPanel(textInput("searchTerm", "Enter data to be searched with '#'", "#"))),
                     
                     tabPanel(title =  "About Project", #Tab For About This Project
                              HTML("<div class = text-center>
                                   <h1 class=text-primary>Twitter Sentiment Analysis</h1>
                                   </div>"))
  ))
)