# phylogram


--------------------------------------------------------------------------------

The **phylogram** R package is a tool for for developing 
phylogenetic trees as deeply-nested lists known as "dendrogram" objects. 
It provides functions for conversion between "dendrogram" and 
"phylo" class objects, as well as several tools for command-line tree 
manipulation and import/export via Newick parenthetic text.
This improves accessibility to the comprehensive range of object-specific 
analytical and tree-visualization functions found across a wide array of 
bioinformatic R packages.


### Installation

To download **phylogram** from CRAN and load the package, run

```R
install.packages("phylogram")
library("phylogram")
```

To download the latest development version from GitHub, run:

```R
devtools::install_github("ropensci/phylogram", build_vignettes = TRUE) 
library("phylogram")
```


### Example: reading and writing trees

Consider the simple example of a tree with three members named 
"A", "B" and "C", where "B" and "C" are more closely related
to eachother than they are to "A". 
An unweighted Newick string for this tree would be "(A,(B,C));".
This text can be imported as a 
dendrogram object using the `read.dendrogram` function 
as follows:

```R
library("phylogram")
newick <- "(A,(B,C));"
x <- read.dendrogram(text = newick)
plot(x)
```

The following command writes the object back to the console in 
Newick format without edge weights:

```R
write.dendrogram(x, edges = FALSE)
```

The syntax is similar when reading and writing text files, 
except that the `text` argument is replaced by `file` and a 
valid file path is passed to the function.

To convert the dendrogram to a "phylo" object, run

```R
y <- as.phylo(x)
```

These and more examples are available in the package vignette.
To view the vignette, run `vignette("phylogram-vignette")` or access it 
directly from [CRAN](https://CRAN.R-project.org/package=phylogram).


### Help

An overview of the package with links to the function documentation can be found by running

```R
?phylogram
```

If you experience a problem using this package please
either raise it as an issue on [GitHub](http://github.com/ropensci/phylogram/issues) 
or post it on the **phylogram** [google group](https://groups.google.com/group/phylogram).


### Acknowledgements

This software was developed at 
[Victoria University of Wellington](http://www.victoria.ac.nz/) 
with funding from a Rutherford Foundation Postdoctoral Research Fellowship 
award from the Royal Society of New Zealand.



