library(eclust)
library(SummarizedExperiment) |> suppressPackageStartupMessages()
dat <- data.frame(matrix(rnorm(100), 20))
se <- SummarizedExperiment(assay = dat)
ec <- eclust(se, direction = "both")
assayNames(ec) <- 'counts'

library(tidytree)
library(tibble)
library(tidyr)
f <- function(ec,bycol = TRUE,assay = 1,longer = FALSE,metada = FALSE) {
    da <- assay(ec, assay) |> data.frame() |> rownames_to_column(var = "label")
    
    if(is.null(assayNames(ec)[assay])){
      name <- 'counts'
    } else {
      name <- assayNames(ec)[assay]
    }
    
    if (bycol) {
      ph <- colhclust(ec) |> as.phylo()
      md <- colData(ec)
      if (longer) {
        da <-pivot_longer(da,cols = !'label',names_to = 'sample',values_to = name
          ) |> nest(counts = c(sample, name))
      }
      
    } else {
      ph <- rowhclust(ec) |> as.phylo()
      md <- rowData(ec)
      if (longer) {
        da <-pivot_longer(da,cols = !'label',names_to = 'feature',values_to = name
          ) |> nest(counts = c(feature, name))
      }
    }
    
    tda <- treedata(phylo = ph) |> left_join(da)
    
    if (metada) {
      md <- as_tibble(md) |> rownames_to_column(var = "label")
      tda <- left_join(tda, md)
    }
    
    return(tda)
}

library(ggtree)
tree <- f(ec, metada = TRUE, longer = TRUE)
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