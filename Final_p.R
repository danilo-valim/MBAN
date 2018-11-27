####################### To Do's ##############################
  
  ####Erase [DONE]
    #Publisher.ID
    #Keyword.ID
    #Keyword.Type

  ####Categorize
    #Match.Type [DONE] [Filled N/A's with 0's]
      '0 - N/A
       1 - Advanced
       2 - Broad
       3 - Exact
       4 - Standard'
    #Publisher.Name
      '1 - Yahoo - US
       2 - MSN - Global
       3 - Google - Global
       4 - Overture - Global
       5 - Google - US
       6 - Overture - US
       7 - MSN - US'
    #Status [Unavailable could be missing value, that's why I put 0's]
      '0 - Unavailable
       1 - Live
       2 - Paused
       3 - Deactivated
       4 - Sent'
    #Bid Strategy [DONE] [Filled blanks with 0] [Misspelled rows categorized with 5]
      '0 - Blanks
       1 - Position 2-5 Bid Strategy
       2 - Position 1- 3
       3 - Position 1-2 Target
       4 - Position 5-10 Bid Strategy
       5 - Position 1-4 Bid Strategy
       6 - Position 1 -2 Target
       7 - Pos 3-6'

  ####Grouping(range) 
    #Search.Engine.Bid

  ####Convert to numeric [DONE]
    #Search.Engine.Bid
    #Click.Charges
    #Cost.per.Click
    #Engine.Click.Thru
    #Trans. Conv. %
    #Total Cost/ Trans.
    #Amount
    #Total Cost

###########################################################

install.packages('readxl')
library(readxl)

setwd('/Users/oscarcastillo/Documents/R')

#Open Data set
data_set <- read_excel("Air France.xls", 
                         sheet = "DoubleClick")
data_set_csv <- read.csv('Air France2.csv')

###Erase STARTS
drop_cols <- c("Keyword ID", "Publisher ID", "Keyword Type")
data_set <- data_set[,!(names(data_set) %in% drop_cols)]

###Convert To Numeric STARTS
change_percentage <- function(x){
  as.numeric(sub("%", "", x))
}

change_dollar <- function(x){
  as.numeric(sub("[$]", "", sub(",","",x)))
}

#Convert Columns $ To Numeric One by One
data_set$`Click Charges` <- change_dollar(data_set$`Click Charges`)
data_set$`Search Engine Bid` <- change_dollar(data_set$`Search Engine Bid`)
data_set$`Avg. Cost per Click` <- change_dollar(data_set$`Avg. Cost per Click`)
data_set$`Total Cost/ Trans.` <- change_dollar(data_set$`Total Cost/ Trans.`)
data_set$Amount <- change_dollar(data_set$Amount)
data_set$`Total Cost` <- change_dollar(data_set$`Total Cost`)

#Convert Columns % To Numeric One by One
data_set$`Engine Click Thru %` <- change_percentage(data_set$`Engine Click Thru %`)
data_set$`Trans. Conv. %` <- change_percentage(data_set$`Trans. Conv. %`)

#Categorize Bid Strategy
data_set$`Bid Strategy`[is.na(data_set$`Bid Strategy`)] <- 0
alias <- unique(data_set$`Bid Strategy`)
data_set$`Bid Strategy` <- gsub(alias[2], 1, data_set$`Bid Strategy`)
data_set$`Bid Strategy` <- gsub(alias[3], 2, data_set$`Bid Strategy`)
data_set$`Bid Strategy` <- gsub(alias[4], 3, data_set$`Bid Strategy`)
data_set$`Bid Strategy` <- gsub(alias[5], 4, data_set$`Bid Strategy`)
data_set$`Bid Strategy` <- gsub(alias[6], 5, data_set$`Bid Strategy`)
data_set$`Bid Strategy` <- gsub(alias[7], 6, data_set$`Bid Strategy`)
data_set$`Bid Strategy` <- gsub(alias[8], 5, data_set$`Bid Strategy`) #misspelling
data_set$`Bid Strategy` <- gsub(alias[9], 7, data_set$`Bid Strategy`)

#Categorize Match Type
alias2 <- unique(data_set$`Match Type`)
data_set$`Match Type` <- gsub(alias2[1], 1, data_set$`Match Type`)
data_set$`Match Type` <- gsub(alias2[2], 2, data_set$`Match Type`)
data_set$`Match Type` <- gsub(alias2[3], 3, data_set$`Match Type`)
data_set$`Match Type` <- gsub(alias2[4], 4, data_set$`Match Type`)
data_set$`Match Type` <- gsub(alias2[5], 0, data_set$`Match Type`)

#Categorize Publisher Name
alias3 <- unique(data_set$`Publisher Name`)
data_set$`Publisher Name` <- gsub(alias3[1], 1, data_set$`Publisher Name`)
data_set$`Publisher Name` <- gsub(alias3[2], 2, data_set$`Publisher Name`)
data_set$`Publisher Name` <- gsub(alias3[3], 3, data_set$`Publisher Name`)
data_set$`Publisher Name` <- gsub(alias3[4], 4, data_set$`Publisher Name`)
data_set$`Publisher Name` <- gsub(alias3[5], 5, data_set$`Publisher Name`)
data_set$`Publisher Name` <- gsub(alias3[6], 6, data_set$`Publisher Name`)
data_set$`Publisher Name` <- gsub(alias3[7], 7, data_set$`Publisher Name`)

#Categorize Status
alias4 <- unique(data_set$Status)
data_set$Status <- gsub(alias4[1], 1, data_set$Status)
data_set$Status <- gsub(alias4[2], 2, data_set$Status)
data_set$Status <- gsub(alias4[3], 3, data_set$Status)
data_set$Status <- gsub(alias4[4], 0, data_set$Status)
data_set$Status <- gsub(alias4[5], 4, data_set$Status)










