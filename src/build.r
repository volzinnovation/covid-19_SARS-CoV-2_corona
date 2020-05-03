library(rmarkdown)
# install.packages("reshape")
library(reshape)
# install.packages("plyr")
library(plyr)
# install.packages("bookdown")
library(bookdown)
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
#countries = c("Taiwan*")
#
# END DEBUG
#

for(country in (countries)) {
  try({
    cat(country)
    filename = str_replace_all(country, c(" "="","\\*"="","US"="USA","'"=""))
    render(file, "bookdown::html_document2", paste0("../reports/latest/",filename,".html"))
    # render(file, "bookdown::pdf_document2", paste0("../reports/latest/",country,".pdf"))
    
  })
}
# Update index.html
render("../index.rmd", "html_document", "../index.html")
# Clean Up broken reports
#
#rm *_files/figure-html/*.png
# rmdir *_files/figure-html
# rmdir *_files
#
# Commit and Push
