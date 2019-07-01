## To be run from the root of the repository
## The lines below are just a rough sketch of what needs to be done to update
## the docs when changing labs/solutions. It hasn't really been tested...
for(i in 1:1){
  rmarkdown::render(paste0("solutions/solution", formatC(i, width=2, flag=0), ".Rmd"),
                    output_format = rmarkdown::github_document(html_preview = FALSE),
                    output_dir = "docs/solutions/")
  rmarkdown::render(paste0("labs/lab", formatC(i, width=2, flag=0), ".Rmd"),
                    output_format = rmarkdown::github_document(html_preview = FALSE),
                    output_dir = "docs/labs/")
}