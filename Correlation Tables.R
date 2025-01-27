#Correlation Tables


library(dplyr)
library(Hmisc)

df <- read.csv("metrics.taxachange.csv")%>%
  filter(Season == "Fall")


cor_with_p <- function(df) {
  cor_test <- rcorr(as.matrix(df[, c("sc.uScm", "rich.PR")]), type = "spearman")
  list(cor = cor_test$r[1, 2], p = cor_test$P[1, 2])
}

results_with_p <- df %>%
  #group_by(Stream) %>%
  do(data.frame(cor_with_p(.)))
print(results_with_p)  
