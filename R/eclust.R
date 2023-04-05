library(eclust)
library(SummarizedExperiment) |> suppressPackageStartupMessages()
dat <- data.frame(matrix(rnorm(100), 20))
se <- SummarizedExperiment(assay = dat)
ec <- eclust(se, direction = "both")

library(tidytree)
library(tibble)
f <- function(ec,bycol = TRUE,assay = 1,longer=FALSE,col,name,value,metada = FALSE) {
  
  da <- assay(ec, assay) |> as_tibble() |> rownames_to_column(var = "label")
  if (longer){
    da <- pivot_longer(da,cols = col,names_to = name,values_to = value)
  }
  
  if (bycol) {
    ph <- colhclust(ec) |> as.phylo()
    md <- colData(ec)
  } else {
    ph <- rowhclust(ec) |> as.phylo()
    md <- rowData(ec)
  }
  
  tda <- treedata(phylo = ph) |> left_join(da)
  
  if (metada) {
    md <- as_tibble(md) |> rownames_to_column(var = "label")
    tda <- left_join(tda, md)
  }
  
  return(tda)
}
library(ggtree)
tree <- f(ec, metada = TRUE,longer = TRUE,col = c(paste0('X',seq(5))),name = "sampleName",value = "count")
tree1 <- f(ec, bycol = FALSE)
ggtree(tree@phylo) + geom_tiplab()
ggtree(tree1@phylo) + geom_tiplab()

# autoplot.eclust <- function(ec, bycol = TRUE, ...) {
#     if (bycol) {
#         hc <- colhclust(ec)
#     } else {
#         hc <- rowhclust(ec)
#     }
#     autoplot.hclust(hc, ...)
# }
