
# rm(list=ls())
# library("ggtree")
# data(iris)
# hc <-hclust(dist(iris[,1:4]))
# p <- ggtree(hc)
# gheatmap(p,iris[,1:4],width = .1,colnames_position = "top",colnames_offset_y = 25,colnames_angle = 90,hjust = 1)


# library(idendr0)
# if (interactive()) {
#   data(iris, envir = environment())
#   hc <- hclust(dist(iris[, 1:4]))
#   idendro(hc, iris)
# }

library(ggtree)
p <- dist(iris[,-5]) %>% hclust() %>% ggtree()
gheatmap(p,iris[,1:4],width = .1,colnames_position = "top",colnames_offset_y = 25,colnames_angle = 90,hjust = 1)+scale_colour_subtree(4)
