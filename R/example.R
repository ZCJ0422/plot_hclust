# Evaluation of Bioinformatics Metrics with evaluomeR
library(evaluomeR)
data("ontMetrics")

# Metric analysis
# 函数输入的ontMetrics是一个SummarizedExperiment对象，
# 函数内的处理方法是，提取ontMetrics中的assay数据，
# 然后使用dist计算距离，使用hclust聚类，最后使用ggdendrogram可视化

plotMetricsCluster(ontMetrics)



# tomoda for tomo-seq data analysis
library(tomoda)
library(SummarizedExperiment)
data("zh.data")

# create an object(SummarizedExpriment class)
zh <- createTomo(zh.data)

# Clustering analysis
# Sometimes it is hard to find borders manually with results above,
# so we include some clustering algorithms to help users do this

# hierarchClust的函数输入是normalized后的assay,
# 具体的处理是，使用dist计算距离（euclidean)
# 然后使用hclust聚类（complete),最后返回hclust对象
hc_zh <- hierarchClust(zh)
plot(hc_zh)

# ggtree系列包，有tidytree,treeio,ggtree,ggtreeExtra
# 其中的treeio是读取各种树文件，转换各种对象为treedata或者phylo，以及一些小的功能比如删减树枝等等，
# tidytree主要是对树结构进行操作，
# 比如转成tibble格式，抽取树枝tips的共同祖先节点，通过父节点查找对应的子节点等，
# ggtree与ggtreeExtra主要是负责可视化，ggtreeExtra是复杂外部（外圈）图层的添加