library(ROAuth)
library(twitteR)

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

TwitterAuthentication()