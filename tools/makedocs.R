## To be run from the root of the repository
## The lines below are just a rough sketch of what needs to be done to update
## the docs when changing labs/solutions. It hasn't really been tested...
notes <- 1:2
sols <- 1
labs <- 1

fname <- function(prefix, i, suffix) {
  paste0(prefix, formatC(i, width=2, flag=0), suffix)
}
encodebackslash <- function(x) gsub("/", "\\\\\\\\/", x)
hackit <- function(fnam) {
  ## edit the output to replace absolute file path by relative path
  thispath <- encodebackslash(getwd())
  newroot  <- encodebackslash("http://spatstat.org/ECAS2019")
  system(paste0("sed s/", thispath, "/", newroot, "/ ", fnam, " > tmp"))
  system(paste("mv tmp", fnam))
}

for(i in sols)
  rmarkdown::render(fname("solutions/solution", i, ".Rmd"),
                    output_format = rmarkdown::github_document(html_preview = FALSE),
                    output_dir = "docs/solutions/")

for(i in labs)
  rmarkdown::render(fname("labs/lab", i, ".Rmd"),
                    output_format = rmarkdown::github_document(html_preview = FALSE),
                    output_dir = "docs/labs/")

for(i in notes) {
  rmarkdown::render(fname("notes/notes", i, ".Rmd"),
                    output_format = rmarkdown::github_document(html_preview = FALSE),
                    output_dir = "docs/notes/")
  hackit(fname("docs/notes/notes", i, ".md"))
}



