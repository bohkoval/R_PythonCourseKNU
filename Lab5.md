#### 1. Написати функцію pmean, яка обчислює середнє значення (mean) забруднення сульфатами або нітратами серед заданого переліка моніторів. Ця функція приймає три аргументи: «directory», «pollutant», «id». Directory – папка, в якій розміщені дані, pollutant – вид забруднення, id – перелік моніторів. Аргумент id має значення за замовчуванням 1:332. Функція повинна ігнорувати NA значення.
``` r
pmean <- function(directory, pollutant, id = 1:332) {
  setwd(file.path(getwd(), directory))
  total = 0
  observations = 0 
  
  for (i in id) {
    if (i < 10) { 
      data <- read.csv(paste("0", "0", as.character(i), ".csv", sep=""), 
                       header = T, 
                       na.strings = c("NA", "NaN", " "))
    } else if (i >= 10 & i < 100) { 
      data <- read.csv(paste("0", as.character(i), ".csv", sep=""),
                       header = T, 
                       na.strings = c("NA", "NaN", " ") 
      )
    } else { 
      data <- read.csv(paste(as.character(i), ".csv", sep=""),
                       header = T, 
                       na.strings = c("NA", "NaN", " ") 
      )
    }

    data = na.omit(data)
    observations = observations + nrow(data)
    if (pollutant == "sulfate") {
      total = total + sum(data$sulfate)
    } else {
      total = total + sum(data$nitrate)
    }
  }
  
  setwd("..")
  return (total/observations)
}

# for output
pmean("specdata", "sulfate")
pmean("specdata", "sulfate", 10)
pmean("specdata", "nitrate", 1:5)
```
```
> pmean("specdata", "sulfate")
[1] 3.194204
> pmean("specdata", "sulfate", 10)
[1] 0.6243649
> pmean("specdata", "nitrate", 1:5)
[1] 0.9058632
```

#### 2. Написати функцію complete, яка виводить кількість повних спостережень (the number of completely observed cases) для кожного файлу. Функція приймає два аргументи: «Directory» та «id» та повертає data frame, в якому перший стовпчик – ім’я файлу, а другий – кількість повних спостережень.
``` r
complete <- function(directory, id = 1:332) {
  dataframe = NULL
  setwd(file.path(getwd(), directory))
  
  for (i in id) {
    if (i < 10) {
      data <- read.csv(paste("0", "0", as.character(i), ".csv", sep=""),
                       header = T, 
                       na.strings = c("NA", "NaN", " "))
    } else if (i >= 10 & i < 100) {
      data <- read.csv(paste("0", as.character(i), ".csv", sep=""),
                       header = T, 
                       na.strings = c("NA", "NaN", " ") 
      )
    } else { 
      data <- read.csv(paste(as.character(i), ".csv", sep=""),   
                       header = T, 
                       na.strings = c("NA", "NaN", " ") 
      )
    }
    
    data = na.omit(data) 
    data = as.matrix(data)
    dataframe = rbind(dataframe, c(i, nrow(data)))
  }
  
  setwd("..")
  dataframe = data.frame(dataframe)
  names(dataframe) = c('id', 'nobs')
  return (dataframe) 
}

# for output
complete("specdata", 10)
complete("specdata", 1:5)
complete("specdata", c(10, 9, 8, 7, 6, 5, 4, 3, 2, 1))
```
```
> complete("specdata", 10)
  id nobs
1 10  148
> complete("specdata", 1:5)
  id nobs
1  1  117
2  2 1041
3  3  243
4  4  474
5  5  402
> complete("specdata", c(10, 9, 8, 7, 6, 5, 4, 3, 2, 1))
   id nobs
1  10  148
2   9  275
3   8  192
4   7  442
5   6  228
6   5  402
7   4  474
8   3  243
9   2 1041
10  1  117
```

#### 3. Написати функцію corr, яка приймає два аргументи: directory (папка, де знаходяться файли спостережень) та threshold (порогове значення, за замовчуванням дорівнює 0) та обчислює кореляцію між сульфатами та нітратами для моніторів, кількість повних спостережень для яких більше порогового значення. Функція повинна повернути вектор значень кореляцій. Якщо ні один монітор не перевищує порогового значення, функція повинна повернути numeric вектор довжиною 0. Для обчислення кореляції між сульфатами та нітратами використовуйте вбудовану функцію «cor» з параметрами за замовчуванням.
``` r
corr <- function(directory, threshold = 0) {
  setwd(file.path(getwd(), directory))
  correlationVector = NULL

  for (i in 1:332) {
    if (i < 10) { 
      data <- read.csv(
        paste("0", "0", as.character(i), ".csv", sep=""),
        header = T, 
        na.strings = c("NA", "NaN", " ")
      )
    } else if (i >= 10 & i < 100) { 
      data <- read.csv(
        paste("0", as.character(i), ".csv", sep=""),
        header = T, 
        na.strings = c("NA", "NaN", " ") 
      )
    } else { 
      data <- read.csv(
        paste(as.character(i), ".csv", sep=""),
        header = T, 
        na.strings = c("NA", "NaN", " ") 
      )
    }
    
    data = na.omit(data) 
    if (nrow(data) > threshold) {
      correlationVector = c(correlationVector, cor(data[,2], data[,3]))
    }
  }
  
  setwd("..")
  return (correlationVector)
}

# for output
output <- corr("specdata", 10)
head(output)
summary(output)

output <- corr("specdata", 100)
head(output)
summary(output)

output <- corr("specdata", 1000)
head(output)
summary(output)
length(output)
```
```
> output <- corr("specdata", 10)
> head(output)
[1] -0.22255256 -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667
> summary(output)
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-0.54537 -0.05363  0.10128  0.13044  0.27401  0.89222 
> output <- corr("specdata", 100)
> head(output)
[1] -0.22255256 -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667
> summary(output)
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-0.28827 -0.05549  0.09034  0.11943  0.26597  0.76313 
> output <- corr("specdata", 1000)
> head(output)
[1] -0.01895754  0.04191777  0.19014198
> summary(output)
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-0.01896  0.01148  0.04192  0.07103  0.11603  0.19014 
> length(output)
[1] 3
```
