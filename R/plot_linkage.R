library("ggtree")
library("mdendro")

d <- dist(scale(mtcars))  # distances of standardized data
lnk <- linkage(d, digits = 1, method = "complete")
lnk.hclust <- as.hclust(lnk)

p <- ggtree(lnk.hclust,layout = "dendrogram")+
     geom_tiplab(angle=90,hjust=1,vjust=.5,as_ylab = TRUE)+geom_tippoint()
p+scale_color_subtree(cutree(lnk.hclust,4))



