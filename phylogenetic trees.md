# [Definition of Formats for Coding Phylogenetic Trees in R](http://ape-package.ird.fr/misc/FormatTreeR_24Oct2012.pdf)

## 1. termiology and notations

| name|value|
| ----------- | ----------- |
| branch | edge, vertex |
| node   | inernal node |
| degree | the number of edges that meet a node |
| tip   | terminal node, leaf, node of degree 1 |
| n    | number of tips |
| m    | number of nodes |

## 2. definition of the class "phylo"

An object of class "phylo" is a list with the following mandatory elements:
* A numeric matrix named **edge** with tow columns and as many rows as there are branches in the trees; 
* A character vector of length *n* named **tip.label** with the labels of the tips; 
* A n integer valune named **Nnode** giving the number of (internal) nodes; 
* An attribute **class** equal to **"phylo"**

The matrix **edge** has the following properties:
* 第一列的值大于n
* 所有的node在第一列至少出现两次
* 所有的元素，除了根节点n+1, 都会在第二列出现一次

##  [supporting dendro class to phylo class](https://github.com/YuLab-SMU/treeio/pull/95)