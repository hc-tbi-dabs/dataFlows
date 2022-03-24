#make HTML

make_index <- function(program, 
                       dir = "C:/Users/SCASTEL/OneDrive - HC-SC PHAC-ASPC/Documents/dataFlows/programs", 
                       cols_node = c("#FABC3C", "#FFB238", "#F19143", "#FF773D", "#F55536"),
                       cols_terminal = c("#5EB1BF","#CDEDF6"),
                       link_alpha = 0.5,
                       title = ""){
  
  program_list <- c("biologics",
                    "border",
                    "cannabis",
                    "clinical_trials",
                    "consumer_products",
                    "controlled_substances",
                    "drugs",
                    "environmental_health_IPP",
                    "labs",
                    "medical_devices",
                    "natural_health_products",
                    "pesticides",
                    "tobacco_vaping")
  
  if(!program %in% program_list){
    stop(paste0("Please choose one of the following programs: ", paste(program_list, collapse = ", ")))
    }
  
  
  filepath <- paste0(dir, "/", program, "/raw/flows.csv")
  
  p <- make_sankey(filepath = filepath, 
                   link_alpha = link_alpha, 
                   cols_node = cols_node, 
                   cols_terminal = cols_terminal,
                   title = title)
  
  widget_file_size <- function(p) {
    d <- paste0(dir, "/", program)
    withr::with_dir(d, htmlwidgets::saveWidget(p, "index.html"))
    f <- file.path(d, "index.html")
    mb <- round(file.info(f)$size / 1e6, 3)
    message("File is: ", mb," MB")
  }
   
  widget_file_size(p)

  message(paste0("An 'index.html' file was generated for program: ", 
                 program, 
                 ".  Please commit and push these changes to GitHub to refresh the data flow visualization on Sharepoint." ))
  
  }


make_index(program = "biologics")

# Use this code to embed
#   <iframe id="igraph" scrolling="no" style="border:none;" seamless="seamless" src="https://hc-tbi-dabs.github.io/dataFlows/" height="1200" width="100%"></iframe>