library(eclust)
library(SummarizedExperiment) |> suppressPackageStartupMessages()
dat <- data.frame(matrix(rnorm(100), 20))
dat2 <- data.frame(matrix(rnorm(100), 20))
dat3 <- data.frame(matrix(rnorm(1), 5))
se <- SummarizedExperiment(assay = dat)
ec <- eclust(se, direction = "both")
assay(ec, 2) <- dat2
metadata(ec@colData) <- dat3

library(tidytree)
library(tibble)
f <- function(object,bycol = TRUE,assay = 1,metada = FALSE) {
  da <- assay(object, assay) |> as_tibble() |> rownames_to_column(var = "label")
  
  if (bycol) {
    ph <- colhclust(object) |> as.phylo()
    ext <- colData(object) |> as_tibble() |> rownames_to_column(var = "label")
    
    if (metada){
      md <- object@colData@metadata 
    }
  } else {
    ph <- rowhclust(object) |> as.phylo()
    ext <- rowData(object) |> as_tibble() |> rownames_to_column(var = "label")
    if (metada){
      md <- object@elementMetadata@metadata 
    }
  }

  tda <- treedata(phylo = ph) |> left_join(da) |> left_join(ext)
  
  if(metada){
    md <- rownames_to_column(md,var = "label")
    tda <- left_join(tda,md)
  }
  return(tda)
}

library(ggtree)
tree <- f(ec,metada = TRUE)
tree1 <- f(ec,bycol = FALSE)
ggtree(tree@phylo) + geom_tiplab()
ggtree(tree1@phylo) + geom_tiplab()


# autoplot.eclust <- function(object, bycol = TRUE, ...) {
#     if (bycol) {
#         hc <- colhclust(object)
#     } else {
#         hc <- rowhclust(object)
#     }
#     autoplot.hclust(hc, ...)
# }
