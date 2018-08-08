library(shiny)

ui <- fluidPage( theme = "bootstrap.css", #Use bootstrap css
                 shinyUI(navbarPage("Twitter Sentiment Analysis", #Main Navbar
                                    
                                    tabPanel("Analysis", #Analysis Tab
                                             
                                             #Designing sidebar components
                                             sidebarPanel(#helpText("When you enter related KEYWORDS, we can search Tweets through Twitter."),
                                                          textInput("searchTerm", "Enter keyword to search tweets:", "Twitter"), #text input for get keywords
                                                          #helpText("How many number of Tweets you want to extract? Select between 5 - 1000"),
                                                          sliderInput("maxTweets","Number of recent tweets to use for analysis:",min=5,max=1000,value=500), #slider for select tweet count 
                                                          #helpText("Pick Start date that require to search"),
                                                          dateInput("date", label ="Select a Date to Start search from:",value = "2017-01-01"), #date picker
                                                          #dateInput("edate", label ="Select End Date:",value = as.character(Sys.Date())), #date picker
                                                          #helpText("Select country that you want to search"),
                                                          selectInput("country", "Select Country:",
                                                                      c("Afghanistan"="33.93911,67.709953,100mi",
                                                                        "Argentina"="-38.416097,-63.616672,100mi",
                                                                        "Australia"="-25.274398,133.775136,100mi",
                                                                        "Bangladesh"="23.684994,90.356331,100mi",
                                                                        "Canada"="56.130366,-106.346771,100mi",
                                                                        "China"="35.86166,104.195397,100mi",
                                                                        "Cuba"="21.521757,-77.781167,100mi",
                                                                        "Croatia"="45.1,15.2,100mi",
                                                                        "Egypt"="26.820553,30.802498,100mi",
                                                                        "France"="46.227638,2.213749,100mi",
                                                                        "Germany"="51.165691,10.451526,100mi",
                                                                        "Indonesia"="-0.789275,113.921327,100mi",
                                                                        "Israel"="31.046051,34.851612,100mi",
                                                                        "India"="20.593684,78.96288,100mi",
                                                                        "Iraq"="33.223191,43.679291,100mi",
                                                                        "Italy"="41.87194,12.56738,100mi",
                                                                        "Jamaica"="18.109581,-77.297508,100mi",
                                                                        "Japan"="36.204824,138.252924,100mi",
                                                                        "Libya"="26.3351,17.228331,100mi",
                                                                        "Malaysia"="4.210484,101.975766,100mi",
                                                                        "North Korea"="40.339852,127.510093,100mi",
                                                                        "Norway"="60.472024,8.468946,100mi",
                                                                        "Philippines"="12.879721,121.774017,100mi",
                                                                        "Pakistan"="30.375321,69.345116,100mi",
                                                                        "Qatar"="25.354826,51.183884,100mi",
                                                                        "Russia"="61.52401,105.318756,100mi",
                                                                        "South Korea"="35.907757,127.766922,100mi",
                                                                        "South Africa"="-30.559482,22.937506,100mi",
                                                                        "Spain"="40.463667,-3.74922,100mi",
                                                                        "Sri Lanka"="7.873054,80.771797,100mi",
                                                                        "Saudi Arabia"="23.885942,45.079162,100mi",
                                                                        "Singapore"="1.352083,103.819836,100mi",
                                                                        "Switzerland"="46.818188,8.227512,100mi",
                                                                        "Syria"="34.802075,38.996815,100mi",
                                                                        "Thailand"="15.870032,100.992541,100mi",
                                                                        "United States"="37.09024,-95.712891,100mi",
                                                                        "United Arab Emirates"="23.424076,53.847818,100mi",
                                                                        "United Kingdom"="55.378051,-3.435973,100mi")),
                                                          submitButton(text="Analyse") #submit keyword and tweet count to the server
                                             ), 
                                             
                                             #Designing mainPanel Components
                                             mainPanel(tabsetPanel(
                                               tabPanel("Results",
                                                        HTML("<div class = text-center><h2>Sentiment Analysis Results</h3></div>"), 
                                                        plotOutput("histPos")),
                                               tabPanel("WordCloud",HTML("<div><h3>Most used words associated with the Keyword that you search!</h3></div>"),plotOutput("word"))
                                             ))),
                                    
                                    tabPanel(title =  "About Project", #Tab For About This Project
                                             HTML("<div class = text-center><h1 class=text-primary>Twitter Sentiment Analysis</h1></div>"),
                                             HTML("<div><p>This project is Develop Under Cloude Computing Group Project.Tweets Directly filter from Twitter API by using user's keywords or #tag keywords. Then Clean Tweets for remove unwonted text effects and formats. Then analyze positivity or negativity of Tweets through the lexical analyzer</p></div>"))
                 ))
)