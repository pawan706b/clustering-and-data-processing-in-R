library(ggplot2)
library(readr)

df <- read_csv('C:\Users\pawan\OneDrive\Desktop\Personal\github\clustering-and-data-processing-in-R\results.csv')

features <- c('DISTINCT_CUSTOMERS', 'TOTAL_REVENUE',
              'BASKETS', 'Average_Quantity_Sold')

par(mfrow=c(2, 2), mar=c(4, 4, 2, 1))

for (feature in features) {
  p <- ggplot(df, aes_string(x='pkm$cluster', y=feature)) +
    geom_bar(stat='summary', fun='mean', fill='viridis', na.rm=TRUE) +
    labs(title=feature, x='pkm$cluster', y='Average') +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  print(p)
}

dev.off()
