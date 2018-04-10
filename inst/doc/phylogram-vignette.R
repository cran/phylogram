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
y <- as.phylo(x)
z <- as.dendrogram(y)
identical(x, z)

