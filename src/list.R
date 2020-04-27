library(rmarkdown)
# install.packages("reshape")
library(reshape)
# install.packages("plyr")
library(plyr)
# install.packages("bookdown")
library(bookdown)
#install.packages("stringr")
library(stringr)
file = "COVID-19.rmd"
countries = c("Germany","Belgium","Austria","Israel","Italy","Spain","US","Switzerland","Sweden","United Kingdom","France","Denmark","Korea, South")  
# Load Data from Johns Hopkins Github Repository
confirmed = read.csv('https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv')
# Transform data to sensible timeseries format
confirmed_t = melt(confirmed, id=c("Province.State","Country.Region","Lat","Long"))
names(confirmed_t) = c("State","Country","Lat","Lon","Date","Confirmed") # Proper Col Names
countries = sort(unique(confirmed_t$Country))
#
# START DEBUG WITH ONLY ONE COUNTRY OF CHOICE
#
# countries = c("Germany")
#
# END DEBUG
#

for(country in countries) {
  filename = str_replace_all(country, c(" "="","\\*"="","US"="USA","'"=""))
  cat(paste0("* [",country,"](https://www.volzinnovation.com/covid-19_SARS-CoV-2_corona/reports/latest/",filename,".html)\n"))
}