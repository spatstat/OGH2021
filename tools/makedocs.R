## To be run from the root of the repository
## The lines below are just a rough sketch of what needs to be done to update
## the docs when changing labs/solutions. It hasn't really been tested...
notes <- 1:2
sols <- 1
labs <- 1

fname <- function(prefix, i, suffix) {
  paste0(prefix, formatC(i, width=2, flag=0), suffix)
}
move_to_docs <- function(x){
  file.rename(x, sub("ECAS2019", "ECAS2019/docs", x, fixed = TRUE))
}

for(i in sols){
  f <- rmarkdown::render(fname("solutions/solution", i, ".Rmd"),
                         output_format = rmarkdown::github_document(html_preview = FALSE))
  move_to_docs(f)
}

for(i in labs){
  f <- rmarkdown::render(fname("labs/lab", i, ".Rmd"),
                         output_format = rmarkdown::github_document(html_preview = FALSE))
  move_to_docs(f)
}

for(i in notes) {
  f <- rmarkdown::render(fname("notes/notes", i, ".Rmd"),
                         output_format = rmarkdown::github_document(html_preview = FALSE))
  move_to_docs(f)
}
