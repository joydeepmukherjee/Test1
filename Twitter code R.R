
#Source: http://www.evoketechnologies.com/blog/sentiment-analysis-r-language/

#Initial packages required to connect to Twitter

install.packages("https://cran.r-project.org/bin/windows/contrib/3.4/RCurl_1.95-4.8.zip", repos =NULL)
install.packages("https://cran.r-project.org/bin/windows/contrib/3.4/bitops_1.0-6.zip", repos =NULL)
install.packages("https://cran.r-project.org/bin/windows/contrib/3.4/twitteR_1.1.9.zip", repos =NULL)

library(plyr)
#Loading the packages
install.packages("RCurl")
library(RCurl) 
install.packages("twitteR") ### for fetching the tweetsl
library(twitteR)
library(data.table)
#Connecting to Twitter (Part 1)

consumer_key <- 'cZ269vPWKujWXgXkVwdHOml9N'
consumer_secret <- '1YzD2IgTQqPqPuJaDVBKg0vUCSvHLhDHdySY5Dl6TxId1kbvSr'
access_token <- '2183660119-ot79MtZCPHkVzgqABWl7mEoWZoVcRTW3gI9z2I7'
access_secret <- 'vUGDUvh1zfumw2PgRgQZ2Li4VFb8QqWUbGZv4WGBoWUui'

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)


#Create an empty data frame

data=data.frame("tweet"=character(0))
saveRDS(data, file="data.Rda")


twitterdata <- function(x){
tweets = searchTwitter(x, lang="en",n=5000)
tweet=laply(tweets,function(t)t$getText())
data_tweet=as.data.frame(tweet,"tweet"=character(256))
edit(data_tweet)
#bar <- readRDS(file="data.Rda")
#newdata=rbind(bar,data_tweet)
#colnames(newdata)<- c("tweet")
#data=newdata
#saveRDS(data, file="data.Rda")
#write.csv(data, file="data.csv")
}

# Try


twitterdata <- function(x){
tweets = searchTwitter(x, lang="en",n=5000)
tweet=laply(tweets,function(t)t$getFollowers(retryOnRateLimit=180))
data_tweet=as.data.frame(tweet,"tweet"=character(256))
edit(data_tweet)
#bar <- readRDS(file="data.Rda")
#newdata=rbind(bar,data_tweet)
#colnames(newdata)<- c("tweet")
#data=newdata
#saveRDS(data, file="data.Rda")
#write.csv(data, file="data.csv")
}

twitterdata("ALBK")



Ndata = read.table("C:/Users/Lab2/Desktop/Working/Twitter/MasterFile.csv", sep=",",header=TRUE)
Tbl = read.table("C:/Users/Lab2/Desktop/Working/Twitter/CompanyList.txt", sep="\t",header=TRUE)
Rc = nrow(Tbl)
for(i in 1:Rc)	{
		CmpName = Tbl$Name[i] 
		CmpIdx = Tbl$Twitter.Handle[i]
		print(CmpIdx) 

tweets = searchTwitter(as.character(CmpIdx), lang="en",n=5000)
tweet=laply(tweets,function(t)t$getText())
Info=data.table(tweet)
#edit(data_tweet)
		#Info = data.table(data_tweet)
		Info[,Company :=CmpName] 
		Info[,Date :=as.Date(Sys.Date())] 
		Ndata = data.table(Ndata)
		Ndata [,Date := as.Date(Date)]
		Ndata = rbind(Ndata ,Info)
		write.csv(Ndata, file="C:/Users/Lab2/Desktop/Team2/MasterFile.csv")		
}


############## 2nd test

companyhouse <- getUser("companyhouse")
location(companyhouse )

sample<-t(sapply(getUser('companyhouse')$getFollowers(), function(x) c(x$name, x$location, x$statusesCount,x$longitude)))
head(sample)     

sample<-t(sapply(getUser('CompaniesHouse')$getFollowers(), function(x) c(x$name, x$location, x$statusesCount)))
head(sample)  

data<-as.data.frame(sample)

write.csv(data,"C:\\Users\\Lab2\\Desktop\\Team2\\data_Company_House.csv")




if (!require("data.table")) {
  install.packages("data.table", repos="http://cran.rstudio.com/") 
  library("data.table")
}
lucaspuente_followers_df = rbindlist(lapply(lucaspuente_follower_IDs,as.data.frame))

head(lucaspuente_followers_df$location, 10)

lucaspuente_followers_df<-subset(lucaspuente_followers_df, location!="")

lucaspuente_followers_df$location<-gsub("%", " ",lucaspuente_followers_df$location)


