#make HTML

widget_file_size <- function(p) {
  d <- getwd()
  withr::with_dir(d, htmlwidgets::saveWidget(p, "index.html"))
  f <- file.path(d, "index.html")
  mb <- round(file.info(f)$size / 1e6, 3)
  message("File is: ", mb," MB")
}
 widget_file_size(p)

 
 widget_file_size(partial_bundle(p))


# Commit, Push

# Use this code to embed
# <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://github.com/castels/dataFlow/blob/main/index.html" height="525" width="100%"></iframe>