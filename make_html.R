#make HTML
filepath <- "C:/Users/SCASTEL/OneDrive - HC-SC PHAC-ASPC/Documents/dataFlows/links/controlled_substances/testData.csv"

  
p <- make_sankey(filepath = filepath, link_alpha = 0.5, 
                 cols_node = c("#FABC3C", "#FFB238", "#F19143", "#FF773D", "#F55536"), 
                 cols_terminal = c("#5EB1BF","#CDEDF6"))



widget_file_size <- function(p) {
  d <- getwd()
  withr::with_dir(d, htmlwidgets::saveWidget(p, "index.html"))
  f <- file.path(d, "index.html")
  mb <- round(file.info(f)$size / 1e6, 3)
  message("File is: ", mb," MB")
}
 widget_file_size(p)

 
 #widget_file_size(partial_bundle(p))


# Commit, Push

# Use this code to embed
# <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://github.com/castels/dataFlow/blob/main/index.html" height="525" width="100%"></iframe>