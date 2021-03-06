
make_sankey <- function(filepath = filepath, 
                        link_alpha = 0.4, 
                        cols_node = c("#FABC3C", "#FFB238", "#F19143", "#FF773D", "#F55536"), 
                        cols_terminal = c("#5EB1BF","#CDEDF6"),
                        title = ""){
  
  # Required libraries
  
  require(plotly)
  require(rjson)
  require(colorspace)
  
  # Read file
  
  pairs_df <- read.csv(filepath)
  
  # Create key
  
  label <- unique(c(pairs_df$from,pairs_df$to))
  index <- 0:(length(label)-1)
      
  key <- data.frame(label = label, index = index)
  
  pairs_df$from_index <- key$index[match(pairs_df$from, key$label)] 
  pairs_df$to_index <- key$index[match(pairs_df$to, key$label)] 
  pairs_df$path_name <- paste0("path ", 1:length(pairs_df$from_index))
  

  # Origins

  origin_name <- pairs_df$from[!(pairs_df$from_index %in% pairs_df$to_index)] 
  origin_index <- pairs_df$from_index[!(pairs_df$from_index %in% pairs_df$to_index)]
  n_origin <- length(unique(origin_name))

  # Terminuses
  
  terminal_name <- pairs_df$to[!(pairs_df$to %in% pairs_df$from)] 
  terminal_index <- pairs_df$to_index[!(pairs_df$to_index %in% pairs_df$from_index)]
  n_terminal <- length(unique(terminal_name))

  # Assign link colours based on origin
  
    # nodes
  
    col_key_origin <- colorRampPalette(cols_node)(n_origin)
    names(col_key_origin) <- unique(origin_name)
    
    col_key_terminal <- colorRampPalette(cols_terminal)(n_terminal)
    names(col_key_terminal) <- unique(terminal_name)
  
    #links
    
    col_key_links <- adjust_transparency(col = col_key_origin, alpha = link_alpha)
    names(col_key_links) <- names(col_key_origin)

  # Initialize origins 
  
  for(i in 1:nrow(pairs_df)){
    pairs_df$origin[i] <- origin_name[match(pairs_df$from[i], origin_name)]
    pairs_df$origin_id[i] <- origin_index[match(pairs_df$from_index[i], origin_index)]
    pairs_df$link_colour[i] <- col_key_links[match(pairs_df$origin[i], names(col_key_links))]
  
  }

  # Determine pathways
    
    for(i in 1:nrow(pairs_df)){
    
    next_node <- pairs_df$to_index[i]
    
    origin_node <- pairs_df$origin[i]
    origin_id_node <- origin_index[match(origin_node, origin_name)]
    origin_colour <- col_key_links[match(origin_node, names(col_key_links))]
    
    pairs_df$origin[which(next_node == pairs_df$from_index[(1:nrow(pairs_df))])] <- origin_node
    pairs_df$origin_id[which(next_node == pairs_df$from_index[(1:nrow(pairs_df))])] <- origin_id_node
    pairs_df$link_colour[which(next_node == pairs_df$from_index[(1:nrow(pairs_df))])] <- origin_colour
    
    }
    
    
  # Determine weights
    
    weights <- apply(table(pairs_df$origin,pairs_df$from),1,max)
    

  # Define node colours
    
  pairs_df$node_colour <- substr(pairs_df$link_colour,1,7)

  # Assign node colours to key
  
    # all
    key$colour <- pairs_df$node_colour[match(key$label, pairs_df$from)]
    
    # terminals
    key$colour[which(key$label %in% unique(terminal_name))] <- col_key_terminal[which(names(col_key_terminal) == unique(terminal_name))]
  
  # Compile data list

  my_data <- list(
    
    node = list(
      label = key$label,
      color = key$colour
      ),
    
    link = list(
      source_data = pairs_df$from_index,
      target_data = pairs_df$to_index,
      weight = as.numeric(pairs_df$weight),
      label = pairs_df$origin,
      colour = pairs_df$link_colour
      )
  )
  
  # Create Sankey diagram

  p <- plot_ly(
    type = "sankey",
    domain = c(
      x =  c(0,1),
      y =  c(0,1)
    ),
    orientation = "h",
    valueformat = ".0f",
    valuesuffix = "",
    
    node = list(
      label = my_data$node$label,
      color = my_data$node$color,
      pad = 50,
      thickness = 70,
      line = list(
        color = NULL,
        width = 0.0001
      )
    ),
    
    link = list(
      source = my_data$link$source_data,
      target = my_data$link$target_data,
      value =  my_data$link$weight,
      label =  my_data$link$path_name,
      color = my_data$link$colour
      
    )
  ) %>% 
    layout(
      title = title,
      font = list(
        size = 12,
        color = 'black'
      ),
      xaxis = list(showgrid = F, zeroline = F, showticklabels = F),
      yaxis = list(showgrid = F, zeroline = F, showticklabels = F),
      plot_bgcolor = 'white',
      paper_bgcolor = 'white'
    )

return(p)
}

