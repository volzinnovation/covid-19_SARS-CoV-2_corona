library(rmarkdown)
# install.packages("reshape")
library(reshape)
# install.packages("plyr")
library(plyr)
# install.packages("bookdown")
library(bookdown)
file = "COVID-19.rmd"
countries = c("Germany","Belgium","Austria","Israel","Italy","Spain","US","Switzerland","Sweden","United Kingdom","France","Denmark","Korea, South")  
# Load Data from Johns Hopkins Github Repository
confirmed = read.csv('COVID-19/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv')
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

for(country in rev(countries)) {
  try({
    cat(country)
    render(file, "bookdown::html_document2", paste0("../reports/latest/",country))
    render(file, "bookdown::pdf_document2", paste0("../reports/latest/",country,".pdf"))
    
  })
}