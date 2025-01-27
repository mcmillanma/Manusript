library(vegan)
library(tidyverse)
library(ggpubr)

chem <- read.csv("chem.pca.csv") %>%
 filter(Stream == "EAS (R)") %>%
  select(-c(Stream:Season)) %>%
  select(-c(hardness.mgl))

chemheat <- heatmap(abs(cor(chem, method = "spearman")), 
                   # Compute pearson correlation (note they are absolute values)
                   col = rev(heat.colors(6)), 
                   Colv = NA, Rowv = NA)
legend("topright", 
       title = "SPC",
       legend =  round(seq(0,1, length.out = 6),1),
       y.intersp = 0.7, bty = "n",
       fill = rev(heat.colors(6)))
chemheat

chem <- read.csv("chem.pca.csv")%>%
  filter(Season == "Spring")

plot <- ggplot(chem, aes(x = sc.uScm, y = hardness.mgl))+
  geom_point() +
  theme_classic()+
  facet_wrap("Stream") +
  stat_cor()
plot

png("hardnessvsscspring.png", width = 650, height = 550)
plot(plot)
dev.off()
