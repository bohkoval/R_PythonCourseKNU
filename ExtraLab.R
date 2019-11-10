install.packages("stringr")

library(stringr)

# util function used in prepare_set
map_col_names <- function(colName) {
  editedColName <- str_replace_all(
    str_replace_all(
      str_replace_all(
        str_replace_all(
          colName,
          "X.U.2116..", ""),
        "X01..", "Gold"),
      "X02..", "Silver"),
    "X03..", "Bronze")
  
  # the rule above was not mentioned in the task
  # but is needed to accomplish the correct replacement
  finalColName <- str_replace_all(editedColName, "X..", "")
  return(finalColName)
}

prepare_set <- function(file_name) {
  csvData <- read.csv(file_name, skip = 1, header = TRUE, encoding="UTF-8",
           stringsAsFactors = FALSE)
  names(csvData)[1] <- "Country"
  originalNames = colnames(csvData)
  modifiedNames = lapply(originalNames, map_col_names);
  names(csvData) <- c(modifiedNames)
  countriesSplitted <- str_split(csvData[, "Country"], "[:space:]\\(", simplify = TRUE)
  csvData[, "Country"] <- countriesSplitted[,1]
  ID <- str_split(countriesSplitted[,2],"\\)", simplify = TRUE)[,1]
  csvData <- cbind(ID, csvData)
  csvData <- csvData[-nrow(csvData),]
  return(csvData)
}

olympics <- prepare_set("olympics.csv")


answer_one <- function() {
  olympics[olympics[, "Gold"] == max(olympics[, "Gold"]),]["Country"][[1]]
}

answer_one()


answer_two <- function() {
  dataSubset = olympics[c("Country", "Summer", "Winter")]
  dataSubset[, "Diff"] <- abs(dataSubset[, "Summer"] - dataSubset[, "Winter"])
  return(dataSubset[dataSubset[, "Diff"] == max(dataSubset[, "Diff"]),]["Country"][[1]])
}

answer_two()


answer_three <- function() {
  dataSubset = olympics[c("Country", "Gold", "Gold.1", "Gold.2")]
  dataSubset <- dataSubset[dataSubset[, "Gold"] >= 1 & dataSubset[, "Gold.1"] >= 1,]
  dataSubset[, "Rel Diff"] <- abs(dataSubset[, "Gold"] - dataSubset[, "Gold.1"]) / dataSubset[, "Gold.2"]
  return(dataSubset[dataSubset[, "Rel Diff"] == max(dataSubset[, "Rel Diff"]),]["Country"][[1]])
}

answer_three()


answer_four <- function() {
  dataSubset = olympics[c("Country", "Gold.2", "Silver.2", "Bronze.2")]
  dataSubset[, "Points"] <- 3 * dataSubset[, "Gold.2"] + 2 * dataSubset[, "Silver.2"] + dataSubset[, "Bronze.2"]
  return(dataSubset[c("Country", "Points")])
}

answer_four()
