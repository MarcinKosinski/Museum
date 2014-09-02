<!--
%\VignetteEngine{knitr::docco_linear}
%\VignetteIndexEntry{The archivist package compendium}
-->

# The archivist package compendium

## Archiving artifacts with their chaining code

Some text about package

```r
library(archivist)
exampleRepoDir <- getwd()
createEmptyRepo( exampleRepoDir )
```


```r
# example 1
library(dplyr)

data("hflights", package = "hflights")
hflights %>%
   group_by(Year, Month, DayofMonth) %>%
   select(Year:DayofMonth, ArrDelay, DepDelay) %>%
   summarise(
      arr = mean(ArrDelay, na.rm = TRUE),
      dep = mean(DepDelay, na.rm = TRUE)
   ) %>%
   filter(arr > 30 | dep > 30) %>%
   saveToRepo( exampleRepoDir )  
```

```
[1] "9013563d1069359f9b7d7a49c49b0a1f"
```


```r
# example 2
library(Lahman)

#players <- group_by(Batting, playerID)
#games <- summarise(players, total = sum(G))
#head(arrange(games, desc(total)), 5)


Batting %.%
   group_by(playerID) %.%
   summarise(total = sum(G)) %.%
   arrange(desc(total)) %.%
   head(5) %>%
   saveToRepo( exampleRepoDir )
```

```
[1] "6defe8a423a1363463a3ed98435c02e8"
```


```r
# example 3
crime.by.state <- read.csv("CrimeStatebyState.csv")
crime.by.state %.%
   filter(State=="New York", Year==2005) %.%
   arrange(desc(Count)) %.%
   select(Type.of.Crime, Count) %.%
   mutate(Proportion=Count/sum(Count)) %.%
   group_by(Type.of.Crime) %.%
   summarise(num.types = n(), counts = sum(Count)) %>%
   saveToRepo( exampleRepoDir )
```

```
[1] "09cbff009bfb9b8535f1bb65f5cdec1b"
```


```r
# example 4
library(ggplot2)

diamonds %.% # start by specifying the data.frame
   group_by(cut, clarity, color) %.%  # The specify the grouping variables
   summarize(
      meancarat = mean(carat, na.rm = TRUE), 
      ndiamonds = length(carat)
   ) %>%
head( 10) %>%
   saveToRepo( exampleRepoDir )
```

```
[1] "6a9d5d46c5c36a0cbe06b4acabcd03e9"
```


```r
# example 5
data(mtcars)
mtcars %.% 
   group_by(cyl, am) %.%
   select(mpg, cyl, wt, am) %.%
   summarise(avgmpg = mean(mpg), avgwt = mean(wt)) %.%
   filter(avgmpg > 20) %>%
   saveToRepo( exampleRepoDir )
```

```
[1] "5bdec4c40eb192e1bf2a23906c0b2365"
```


```r
# summary
showLocalRepo( exampleRepoDir )[, 2]
```

```
[1] "hflights %>% group_by(Year, Month, DayofMonth) %>% select(Year:DayofMonth,     ArrDelay, DepDelay) %>% summarise(arr = mean(ArrDelay, na.rm = TRUE),     dep = mean(DepDelay, na.rm = TRUE)) %>% filter(arr > 30 |     dep > 30)"                              
[2] "Batting %.% group_by(playerID) %.% summarise(total = sum(G)) %.%     arrange(desc(total)) %.% head(5)"                                                                                                                                                         
[3] "crime.by.state %.% filter(State == \"New York\", Year == 2005) %.%     arrange(desc(Count)) %.% select(Type.of.Crime, Count) %.%     mutate(Proportion = Count/sum(Count)) %.% group_by(Type.of.Crime) %.%     summarise(num.types = n(), counts = sum(Count))"
[4] "diamonds %.% group_by(cut, clarity, color) %.% summarize(meancarat = mean(carat,     na.rm = TRUE), ndiamonds = length(carat)) %>% head(10)"                                                                                                                   
[5] "mtcars %.% group_by(cyl, am) %.% select(mpg, cyl, wt, am) %.%     summarise(avgmpg = mean(mpg), avgwt = mean(wt)) %.% filter(avgmpg >     20)"                                                                                                                 
```

```r
showLocalRepo( exampleRepoDir, "tags" )[,-3]
```

```
                           artifact
1  9013563d1069359f9b7d7a49c49b0a1f
2  9013563d1069359f9b7d7a49c49b0a1f
3  9013563d1069359f9b7d7a49c49b0a1f
4  9013563d1069359f9b7d7a49c49b0a1f
5  9013563d1069359f9b7d7a49c49b0a1f
6  9013563d1069359f9b7d7a49c49b0a1f
7  9013563d1069359f9b7d7a49c49b0a1f
8  9013563d1069359f9b7d7a49c49b0a1f
9  6defe8a423a1363463a3ed98435c02e8
10 6defe8a423a1363463a3ed98435c02e8
11 6defe8a423a1363463a3ed98435c02e8
12 6defe8a423a1363463a3ed98435c02e8
13 6defe8a423a1363463a3ed98435c02e8
14 09cbff009bfb9b8535f1bb65f5cdec1b
15 09cbff009bfb9b8535f1bb65f5cdec1b
16 09cbff009bfb9b8535f1bb65f5cdec1b
17 09cbff009bfb9b8535f1bb65f5cdec1b
18 09cbff009bfb9b8535f1bb65f5cdec1b
19 09cbff009bfb9b8535f1bb65f5cdec1b
20 6a9d5d46c5c36a0cbe06b4acabcd03e9
21 6a9d5d46c5c36a0cbe06b4acabcd03e9
22 6a9d5d46c5c36a0cbe06b4acabcd03e9
23 6a9d5d46c5c36a0cbe06b4acabcd03e9
24 6a9d5d46c5c36a0cbe06b4acabcd03e9
25 6a9d5d46c5c36a0cbe06b4acabcd03e9
26 6a9d5d46c5c36a0cbe06b4acabcd03e9
27 6a9d5d46c5c36a0cbe06b4acabcd03e9
28 5bdec4c40eb192e1bf2a23906c0b2365
29 5bdec4c40eb192e1bf2a23906c0b2365
30 5bdec4c40eb192e1bf2a23906c0b2365
31 5bdec4c40eb192e1bf2a23906c0b2365
32 5bdec4c40eb192e1bf2a23906c0b2365
33 5bdec4c40eb192e1bf2a23906c0b2365
34 5bdec4c40eb192e1bf2a23906c0b2365
                                                                                                                                                                                                                                                                 tag
1                              name:hflights %>% group_by(Year, Month, DayofMonth) %>% select(Year:DayofMonth,     ArrDelay, DepDelay) %>% summarise(arr = mean(ArrDelay, na.rm = TRUE),     dep = mean(DepDelay, na.rm = TRUE)) %>% filter(arr > 30 |     dep > 30)
2                                                                                                                                                                                                                                                       varname:Year
3                                                                                                                                                                                                                                                      varname:Month
4                                                                                                                                                                                                                                                 varname:DayofMonth
5                                                                                                                                                                                                                                                        varname:arr
6                                                                                                                                                                                                                                                        varname:dep
7                                                                                                                                                                                                                                                   class:grouped_df
8                                                                                                                                                                                                                                           date:2014-09-02 19:59:29
9                                                                                                                                                         name:Batting %.% group_by(playerID) %.% summarise(total = sum(G)) %.%     arrange(desc(total)) %.% head(5)
10                                                                                                                                                                                                                                                  varname:playerID
11                                                                                                                                                                                                                                                     varname:total
12                                                                                                                                                                                                                                                      class:tbl_df
13                                                                                                                                                                                                                                          date:2014-09-02 19:59:30
14 name:crime.by.state %.% filter(State == "New York", Year == 2005) %.%     arrange(desc(Count)) %.% select(Type.of.Crime, Count) %.%     mutate(Proportion = Count/sum(Count)) %.% group_by(Type.of.Crime) %.%     summarise(num.types = n(), counts = sum(Count))
15                                                                                                                                                                                                                                             varname:Type.of.Crime
16                                                                                                                                                                                                                                                 varname:num.types
17                                                                                                                                                                                                                                                    varname:counts
18                                                                                                                                                                                                                                                      class:tbl_df
19                                                                                                                                                                                                                                          date:2014-09-02 19:59:31
20                                                                                                                  name:diamonds %.% group_by(cut, clarity, color) %.% summarize(meancarat = mean(carat,     na.rm = TRUE), ndiamonds = length(carat)) %>% head(10)
21                                                                                                                                                                                                                                                       varname:cut
22                                                                                                                                                                                                                                                   varname:clarity
23                                                                                                                                                                                                                                                     varname:color
24                                                                                                                                                                                                                                                 varname:meancarat
25                                                                                                                                                                                                                                                 varname:ndiamonds
26                                                                                                                                                                                                                                                  class:grouped_df
27                                                                                                                                                                                                                                          date:2014-09-02 19:59:31
28                                                                                                                name:mtcars %.% group_by(cyl, am) %.% select(mpg, cyl, wt, am) %.%     summarise(avgmpg = mean(mpg), avgwt = mean(wt)) %.% filter(avgmpg >     20)
29                                                                                                                                                                                                                                                       varname:cyl
30                                                                                                                                                                                                                                                        varname:am
31                                                                                                                                                                                                                                                    varname:avgmpg
32                                                                                                                                                                                                                                                     varname:avgwt
33                                                                                                                                                                                                                                                  class:grouped_df
34                                                                                                                                                                                                                                          date:2014-09-02 19:59:32
```

```r
summaryLocalRepo( exampleRepoDir )
```

```
Number of archived artifacts in the Repository:  5 
Number of archived datasets in the Repository:  0 
Number of various classes archived in the Repository: 
            Number
grouped_df      3
tbl_df          2
Saves per day in the Repository: 
            Saves
2014-09-02     5
```




