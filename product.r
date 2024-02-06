library(ggplot2)
library(GGally)
library(DMwR)
set.seed(5580)

boxplot(product$BASKETS)
ggpairs(product[,which(names(product)!="ITEM_SK")], upper = list(continuous = ggally_points),
 lower = list(continuous = "points"), title = "Products before outlier removal")

boxplot(product$DISTINCT_CUSTOMERS, main = "DISTINCT_CUSTOMERS")
boxplot(product$TOTAL_REVENUE, main = "TOTAL_REVENUE")
boxplot(product$BASKETS, main = "BASKETS")
boxplot(product$Average_Quantity_Sold, main = "Average_Quantity_Sold")

# Clean
items_to_remove <- c(11740941, 11612777, 11743100)						                                                           
product.clean <- subset(product, !(ITEM_SK %in% items_to_remove))
product.clean <- product[product$ITEM_SK != 11612777,]

ggpairs(product.clean[,which(names(product.clean)!="ITEM_SK")], upper = list(continuous = 
ggally_points), lower = list(continuous = "points"), title = "Products after removing outliers")

boxplot(product.clean$DISTINCT_CUSTOMERS, main = "DISTINCT_CUSTOMERS")
boxplot(product.clean$TOTAL_REVENUE, main = "TOTAL_REVENUE")
boxplot(product.clean$BASKETS, main = "BASKETS")
boxplot(product.clean$Average_Quantity_Sold, main = "Average_Quantity_Sold")

# Scaling
product.scale = scale(product.clean[-1])
View(product.scale)

withinSSrange <- function(data,low,high,maxIter)
{
   withinss = array(0, dim=c(high-low+1));
   for(i in low:high)
   {
      withinss[i-low+1] <- kmeans(data, i, maxIter)$tot.withinss
   }
   withinss
} 
plot(withinSSrange(product.scale, 1, 50, 150))

pkm = kmeans(product.scale, 6, 150)
product.realCenters = unscale(pkm$centers, product.scale)
clusteredProduct = cbind(product.clean, pkm$cluster)
plot(clusteredProduct[,2:5], col=pkm$cluster)
write.csv(clusteredProduct, file = "C:/Users/pawan/OneDrive/Desktop/Personal/github/clustering-and-data-processing-in-R/results/results.csv", col.names = FALSE)