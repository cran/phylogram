## ---- echo = FALSE, message = FALSE, warning = FALSE---------------------
#knitr::opts_chunk$set(out.width='750px', dpi=200)
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ------------------------------------------------------------------------
x <- list(1, list(2, 3))
## attach "leaf" and "label" attributes to leaf nodes
attr(x[[1]], "leaf") <- TRUE
attr(x[[2]][[1]], "leaf") <- attr(x[[2]][[2]], "leaf") <- TRUE
attr(x[[1]], "label") <- "A"
attr(x[[2]][[1]], "label") <- "B"
attr(x[[2]][[2]], "label") <- "C"
## set "height" attributes for all nodes
attr(x, "height") <- 1
attr(x[[1]], "height") <- 0
attr(x[[2]], "height") <- 0.5
attr(x[[2]][[1]], "height") <- attr(x[[2]][[2]], "height") <- 0
## set "midpoints" attributes for all nodes
attr(x, "midpoint") <- 0.75
attr(x[[1]], "midpoint") <- 0
attr(x[[2]], "midpoint") <- 0.5
attr(x[[2]][[1]], "midpoint") <- attr(x[[2]][[2]], "midpoint") <- 0
## set "members" attributes for all nodes
attr(x, "members") <- 3
attr(x[[1]], "members") <- 1
attr(x[[2]], "members") <- 2
attr(x[[2]][[1]], "members") <- attr(x[[2]][[2]], "members") <- 1
## set class as "dendrogram" 
## Note that setting the class for the root node
## automatically sets the class of all nested subnodes
class(x) <- "dendrogram"

### plot the dendrogram
plot(x, yaxt = "n")

## ------------------------------------------------------------------------
library(phylogram)
newick <- "(A,(B,C));"
x <- read.dendrogram(text = newick)
x

## ------------------------------------------------------------------------
write.dendrogram(x, edges = FALSE)

## ------------------------------------------------------------------------
library(ape)
data(woodmouse)
## view the first few rows and columns 
as.character.DNAbin(woodmouse[1:5, 1:5])

## ------------------------------------------------------------------------
woodmouse <- woodmouse[, apply(woodmouse, 2, function(v) !any(v == 0xf0))]

## ------------------------------------------------------------------------
### Compute the full distance matrix and print the first few rows and columns
woodmouse.kdist <- kdistance(woodmouse, k = 5)
print(as.matrix(woodmouse.kdist)[1:7, 1:7], digits = 2)

### Compute and print the embedded distance matrix
set.seed(999)
seeds <- sample(1:15, size = 3)
woodmouse.mbed <- mbed(woodmouse, seeds = seeds, k = 5)
### remove the attributes for printing by subsetting the distance matrix
print(woodmouse.mbed[,], digits = 2)

## ---- out.width='700px', out.height='550px', dpi=500---------------------
## set out plotting panes
op <- par(no.readonly = TRUE)
par(mfrow = c(1, 3), mar = c(1, 2, 3, 3), cex = 0.3)

## (1) neighbor joining tree with Kimura 1980 distance
### compute the n x n K80 distance matrix 
woodmouse.dist <- ape::dist.dna(woodmouse, model = "K80") 
### build the neighbor-joining tree
tree1.phylo <- ape::nj(woodmouse.dist)
### export as Newick text
tree1.newick <- ape::write.tree(tree1.phylo)
### import as "dendrogram" object
tree1.dendro <- read.dendrogram(text = tree1.newick)
### sort nodes by size
tree1.dendro <- ladder(tree1.dendro)
### plot the nj tree
plot(tree1.dendro, horiz = TRUE, yaxt = "n", 
     main = "Neighbor-joining tree with\nK80 distance matrix")

## (2) neighbor joining tree with k-mer distance
### compute the n x n k-mer distance matrix 
woodmouse.kdist <- kdistance(woodmouse, k = 5) 
### build the neighbor-joining tree
tree2.phylo <- ape::nj(woodmouse.kdist)
### export as Newick text
tree2.newick <- ape::write.tree(tree2.phylo)
### import as "dendrogram" object
tree2.dendro <- read.dendrogram(text = tree2.newick)
### sort nodes by size
tree2.dendro <- ladder(tree2.dendro)
### plot the nj tree
plot(tree2.dendro, horiz = TRUE, yaxt = "n", 
     main = "Neighbor-joining tree with\nk-mer distance matrix (k=5)")

## (3) topdown tree without distance matrix
set.seed(999)
tree3 <- phylogram::topdown(woodmouse, k = 5, nstart = 20)
### sort nodes by size
tree3 <- phylogram::ladder(tree3)
### plot the topdown tree
plot(tree3, horiz = TRUE, yaxt = "n", 
     main = "Top-down tree without\ndistance matrix (k=5)")

## reset plotting parameters
par(op)

