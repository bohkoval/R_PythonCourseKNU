#### 1. Функція add2(x, y), яка повертає суму двох чисел.
``` r
add2 <- function(x, y) {
  x + y
}

# for output
add2(10, 20)
```
```
[1] 30
```

#### 2. Функція above(x, n), яка приймає вектор та число n, та повертає всі елементі вектору, які більше n. По замовчуванню n = 10.
``` r
above <- function(x, n = 10) {
  result <- x[x > n]
  return (result)
}

# for output
above(1:100, 95)
```
```
[1]  96  97  98  99 100
```

#### 3. Функція my_ifelse(x, exp, n), яка приймає вектор x, порівнює всі його елементи за допомогою exp з n, та повертає елементи вектору, які відповідають умові expression. Наприклад, my_ifelse(x, “>”, 0) повертає всі елементи x, які більші 0. Exp може дорівнювати “<”, “>”, “<=”, “>=”, “==”. Якщо exp не співпадає ні з одним з цих виразів, повертається вектор x.
``` r
my_ifelse <- function(x, exp, n = 10) {
  if (exp == "<") {
    result <- x[x<n]
  } else if (exp == ">") {
    result <- x[x>n]
  } else if (exp == "<=") {
    result <- x[x<=n]
  } else if (exp == ">=") {
    result <- x[x>=n]
  } else if (exp == "==") {
    result <- x[x==n]
  } else {
    result <- x
  }
  
  return(result)
}

# for output
my_ifelse(1:100, "<=", 5)
```
```
[1] 1 2 3 4 5
```

#### 4. Функція columnmean(x, removeNA), яка розраховує середнє значення (mean) по кожному стовпцю матриці, або data frame. Логічний параметр removeNA вказує, чи видаляти NA значення. По замовчуванню він дорівнює TRUE.
``` r
columnmean <- function(x, removeNA=TRUE) {
  n <- ncol(x)
  mean_col <- numeric(n)
  for (i in 1:n){
    mean_col[i]<-mean(x[,i],na.rm=removeNA)
  }
  mean_col
}

# for output
matrix_for_output <- matrix(100:105, nrow=2, ncol=3)
print(columnmean(matrix_for_output))
```
```
[1] 100.5 102.5 104.5
```
