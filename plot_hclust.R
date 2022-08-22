
# rm(list=ls())
# library("ggtree")
# data(iris)
# hc <-hclust(dist(iris[,1:4]))
# p <- ggtree(hc)
# gheatmap(p,iris[,1:4],width = .1,colnames_position = "top",colnames_offset_y = 25,colnames_angle = 90,hjust = 1)

plot_hclust <- function(hc,data,...){
  p <- ggtree(hc,...)
  gheatmap(p,data,width = .1,colnames_position = "top",colnames_offset_y = 25,colnames_angle = 90,hjust = 1)
}

rm(list=ls())
data(iris)
hc <-hclust(dist(iris[,1:4]))
plot_hclust(hc,iris[,1:4])
