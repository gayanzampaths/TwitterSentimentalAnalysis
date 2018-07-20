#use sentiment package
#install.packages("devtools")
#library(devtools)
#install_github('sentiment140', 'okugami79')

#Installing require packages
CheckPackages<-function(){
  InstallPKGS("twitteR")
  InstallPKGS("stringr")
  InstallPKGS("ROAuth")
  InstallPKGS("RCurl")
  InstallPKGS("ggplot2")
  InstallPKGS("reshape")
  InstallPKGS("tm")
  InstallPKGS("RJSONIO")
  InstallPKGS("wordcloud")
  InstallPKGS("gridExtra")
  InstallPKGS("plyr")
  InstallPKGS("e1071")
  InstallPKGS("RTextTools")
  InstallPKGS("syuzhet")
}

InstallPKGS<-function(pkg){
  pkg <- as.character(pkg)
  if (!require(pkg,character.only=TRUE)){
    install.packages(pkgs=pkg,repos="http://cran.r-project.org")
    require(pkg,character.only=TRUE)
  }
}

ImportLibs<-function(){
  #Librarys that require for authentication.
  library(ROAuth)
  library(twitteR)
  library(tm)
  library(wordcloud)
  library(syuzhet)
}

#Authentication to Twitter API
TwitterAuthentication<-function(){
  #API Credintials
  consumer_key <- "6uaOw918wGkp2WcfeATgz0V57"
  consumer_secret <- "0SteX2WTiktzbNcbp56pIxqDS1QoBk9lM4ALvU3A3pLE44jpto"
  access_token <- "194895387-saVTR6eLIogZdX09rcBwhRLLbmlx9JfK5WQueJxX"
  access_secret <- "Y7zJa05Nyg0SUh7aDJdEaf4aeGcX6VmW6IlOxs2Dld502"
  
  #Download SSL Certificates
  download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")
  
  setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
  
  #Calling API Authentication Endpoint
  cred <- OAuthFactory$new(consumerKey=consumer_key, 
                           consumerSecret=consumer_secret,
                           requestURL='https://api.twitter.com/oauth/request_token',
                           accessURL='https://api.twitter.com/oauth/access_token',
                           authURL='https://api.twitter.com/oauth/authorize')
  
  #Authentication Process (Pin no will Require)
  cred$handshake(cainfo="cacert.pem")
}

CheckPackages()
ImportLibs()
TwitterAuthentication()

server <- function(input, output, session) {
  
  #convert tweets to a data frame and cleaning the tweets.
  TweetFrame<-function(twtList){
    df<- do.call("rbind",lapply(twtList,as.data.frame))
    #removes emojies
    df$text <- sapply(df$text,function(row) iconv(row, "latin1", "ASCII", sub=""))
    #remove twitterhandles
    df$text = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", df$text)
    df$text = gsub("@\\w+", "", df$text)
    #remove links
    df$text = gsub("http[^[:blank:]]+", "", df$text)
    #remove punctuations
    df$text = gsub("[[:punct:]]", "", df$text)
    return (df$text)
  }
  
  #Create WordCloud
  wordclouds<-function(text){
    corpus <- Corpus(VectorSource(text))
    #clean text
    clean_text <- tm_map(corpus, removePunctuation)
    #clean_text <- tm_map(clean_text, content_transformation)
    clean_text <- tm_map(clean_text, content_transformer(tolower))
    clean_text <- tm_map(clean_text, removeWords, stopwords("english"))
    clean_text <- tm_map(clean_text, removeNumbers)
    clean_text <- tm_map(clean_text, stripWhitespace)
    return (clean_text)
  }
  
  #extracting tweets
  twtList<-reactive({twtList<-searchTwitter(input$searchTerm, n=input$maxTweets, lang="en") })
  #call dataframe
  tweets<-reactive({tweets<-TweetFrame(twtList() )})
  
  #creating wordcloud
  text_word<-reactive({text_word<-wordclouds( tweets() )})
  output$word <- renderPlot({ wordcloud(text_word(),random.order=F,max.words=80, col=rainbow(100), scale=c(4.5, 1)) })
  
  #sentiment analysis
  sentimentScore<-reactive({sentimentScore<-get_nrc_sentiment(tweets())})
  
  sentimentDataFrame<-function(tweets){
    sc<-sentimentScore()
    ss<-data.frame(colSums(sc[,]))
    names(ss)<-"score"
    ss<-cbind("Sentiment" = rownames(ss),ss)
    rownames(ss)<-NULL
    return(ss)
  }
  
  output$histPos<-reactive({output$histPos<-renderPlot(
    ggplot(sentimentDataFrame(tweets), aes(x = Sentiment, y = score)) + geom_bar(stat = "identity")
  )})
}