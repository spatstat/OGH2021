## To be run from the root of the repository
## The lines below are just a rough sketch of what needs to be done to update
## the docs when changing labs/solutions. It hasn't really been tested...
notes <- 1:2
sols <- 1
labs <- 1
for(i in sols)
  rmarkdown::render(paste0("solutions/solution", formatC(i, width=2, flag=0), ".Rmd"),
                    output_format = rmarkdown::github_document(html_preview = FALSE),
                    output_dir = "docs/solutions/")

for(i in labs)
  rmarkdown::render(paste0("labs/lab", formatC(i, width=2, flag=0), ".Rmd"),
                    output_format = rmarkdown::github_document(html_preview = FALSE),
                    output_dir = "docs/labs/")

for(i in notes) 
  rmarkdown::render(paste0("notes/notes", formatC(i, width=2, flag=0), ".Rmd"),
                    output_format = rmarkdown::github_document(html_preview = FALSE),
                  output_dir = "docs/notes/")
