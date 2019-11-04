#### 1. Створити змінні базових (atomic) типів. Базові типи: character, numeric, integer, complex, logical.
``` r
#character
chrctr <- "character"

#numeric
n <- 10

#integer
i <- as.integer(99)
i <- 99L

#complex
c <- 2i + 1

#logical
bool <- TRUE
```

#### 2. Створити вектори, які: містить послідовність з 5 до 75; містить числа 3.14, 2.71, 0, 13; 100 значень TRUE.
``` r
v1 <- 5:75

v2 <- c(3.14, 2.71, 0, 13)

v3 <- rep(TRUE, times=100)
```

#### 3. Створити наступну матрицю за допомогою matrix, та за допомогою cbind або rbind
``` r
#matrix
m1 <- matrix(
  c(0.5, 3.9, 0, 2, 1.3, 131, 2.2, 7, 3.5, 2.8, 4.6, 5.1),
  nrow = 4,
  ncol = 3
)

#cbind
m2_col1 <- c(0.5, 3.9, 0, 2)
m2_col2 <- c(1.3, 131, 2.2, 7)
m3_col3 <- c(3.5, 2.8, 4.6, 5.1)
m2 <- cbind(m2_col1, m2_col2, m3_col3)
```

#### 4. Створити довільний список (list), в який включити всі базові типи.
``` r
various_list <- list("character", 10, as.integer(99), 2i + 1, TRUE)
```

#### 5. Створити фактор з трьома рівнями «baby», «child», «adult».
``` r
f <- factor(
  c("baby", "child", "adult", "baby", "child", "baby", "child", "adult", "adult"),
  levels = c("baby", "child", "adult")
)
```

#### 6. Знайти індекс першого значення NA в векторі 1, 2, 3, 4, NA, 6, 7, NA, 9, NA, 11. Знайти кількість значень NA.
``` r
vec <- c(1, 2, 3, 4, NA, 6, 7, NA, 9, NA, 11)
```
``` r
match(NA, vec)
```
```
[1] 5
```
``` r
na_count <- length(vec[is.na(vec)])
```
```
[1] 3
```

#### 7. Створити довільний data frame та вивести в консоль.
``` r
d_frame <- data.frame(
  id = c(1:5), 
  name = c("Petro","Vasyl","Mykhailo","Volodymyr","Alex"),
  salary = c(623.3, 515.2, 611.0, 729.0, 843.25),
  start_date = as.Date(c("2019-01-01", "2019-09-23", "2019-11-15", "2019-05-11",
                         "2019-03-27")),
  stringsAsFactors = FALSE
)
print(d_frame) 
```
```
  id      name salary start_date
1  1     Petro 623.30 2019-01-01
2  2     Vasyl 515.20 2019-09-23
3  3  Mykhailo 611.00 2019-11-15
4  4 Volodymyr 729.00 2019-05-11
5  5      Alex 843.25 2019-03-27
```

#### 8. Змінити імена стовпців цього data frame.
``` r
names(d_frame) <- c("ID Number", "Person Name", "Salary", "Start Date")
print(d_frame)
```
```
  ID Number Person Name Salary Start Date
1         1       Petro 623.30 2019-01-01
2         2       Vasyl 515.20 2019-09-23
3         3    Mykhailo 611.00 2019-11-15
4         4   Volodymyr 729.00 2019-05-11
5         5        Alex 843.25 2019-03-27
```
