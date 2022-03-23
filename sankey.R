
library(plotly)
library(rjson)
library(colorspace)

pairs <- list(
  
  # First Node
  
    # OCS
    c(from = "OCS", to = "Licensed Dealer Inspections (OCS)", weight = 21),
    c(from = "OCS", to = "Pharmacy Inspections (OCS)", weight = 4),
    
    # CSP
    c(from = "CSP", to = "Destruction Activities (CSP)", weight = 2),
    c(from = "CSP", to = "Licensed Dealer Inspections (CSP)", weight = 5),
    c(from = "CSP", to = "Pharmacy Inspections (CSP)", weight = 2),
    
    # POD
    c(from = "POD", to = "SAP PS Time Tracking", weight = 3),

  # Second Node
  
    # CSP
    c(from = "Licensed Dealer Inspections (CSP)", to = "Class A Precursor Inspection Report", weight = 1),
    c(from = "Licensed Dealer Inspections (CSP)", to = "CDS Inspection Report", weight = 1),
    c(from = "Licensed Dealer Inspections (CSP)", to = "Border Center Database", weight = 1),
  
    c(from ="Pharmacy Inspections (CSP)", to = "Community Pharmacy Internal Inspection Report", weight = 1),
    c(from = "Pharmacy Inspections (CSP)", to = "Community Pharmacy Inspection Report", weight = 1),
  
    c(from = "Destruction Activities (CSP)", to = "Destruction Tracker", weight = 1),
    c(from = "Destruction Activities (CSP)", to = "Destruction Application", weight = 1),
  
  
    # OCS
    c(from = "Licensed Dealer Inspections (OCS)", to = "Site Risk Profile - LD", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "List of Licensees - CDS", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "List of Licensees - Chemical Precursors", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "Loss & Theft Report", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "Monthly Activity Report - CDS", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "Annual Report - CDS", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "Ephedrine Monthly Report", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "Import Permit Info", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "License Application and Amendment Requests", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "Annual Report - Chemical Precursors", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "Export Info (Permit & Transactions)", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "List of Designated Personnel - CDS", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "Correspondance File from LD", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "Notice of Restrictions for Pharmacist and LD", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "Compliance Action (Regulatory Letter)", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "LD Profile for Precursor", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "S.56 Exemption Letter", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "S.56 Exemption Holder Dispensing Tracker", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "LD License Including T&C", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "NDS 7", weight = 1),
    c(from = "Licensed Dealer Inspections (OCS)", to = "Observation Tracker", weight = 1),
    
    c(from = "Pharmacy Inspections (OCS)", to = "Site Risk Profile - PI", weight = 1),
    c(from = "Pharmacy Inspections (OCS)", to = "List of Pharmacies", weight = 1),
    c(from = "Pharmacy Inspections (OCS)", to = "Loss & Theft Report / Suspicious Transactions - PI", weight = 1),
    
  # Intermediate steps
  
    c(from = "Class A Precursor Inspection Report", to = "Manual Data Entry into Excel (OCS)", weight = 1),
    c(from = "CDS Inspection Report", to = "Manual Data Entry into Excel (OCS)", weight = 1),
    c(from = "Community Pharmacy Internal Inspection Report", to = "Manual Data Entry into Excel (OCS)", weight = 1),
    c(from = "Community Pharmacy Inspection Report", to = "Manual Data Entry into Excel (OCS)", weight = 1),
    
    c(from = "Manual Data Entry into Excel (OCS)", to = "LD Inspection Tracker", weight = 2),
    c(from = "Manual Data Entry into Excel (OCS)", to = "Pharmacy Inspection Tracker", weight = 2),
  
  # Third Node
  
    c(from =  "LD Inspection Tracker", to = "Y:// Drive", weight = 2),
    c(from =  "SAP PS Time Tracking", to = "Y:// Drive", weight = 3),
    c(from =  "Class A Precursor Inspection Report", to = "Database", weight = 1),
    c(from =  "Site Risk Profile - LD", to = "Unknown", weight = 1),
    c(from =  "List of Licensees - CDS", to = "Database", weight = 1),
    c(from =  "List of Licensees - Chemical Precursors", to = "Database", weight = 1),
    c(from =  "Loss & Theft Report", to = "Unknown", weight = 1),
    c(from =  "Monthly Activity Report - CDS", to = "Unknown", weight = 1),
    c(from =  "Annual Report - Chemical Precursors", to = "Unknown", weight = 1),
    c(from =  "Export Info (Permit & Transactions)", to = "Y:// Drive", weight = 1),
    c(from =  "List of Designated Personnel - CDS", to = "Unknown", weight = 1),
    c(from =  "Correspondance File from LD", to = "Unknown", weight = 1),
    c(from =  "License Application and Amendment Requests", to = "Y:// Drive", weight = 1),
    c(from =  "Annual Report - CDS", to = "Unknown", weight = 1),
    c(from =  "Ephedrine Monthly Report", to = "Unknown", weight = 1),
    c(from =  "Import Permit Info", to = "Y:// Drive", weight = 1),
    c(from =  "Site Risk Profile - PI", to = "Unknown", weight = 1),
    
    
    c(from =  "Notice of Restrictions for Pharmacist and LD", to = "Web", weight = 1),
    c(from =  "Compliance Action (Regulatory Letter)", to = "Unknown", weight = 1),
    c(from =  "LD Profile for Precursor", to = "Unknown", weight = 1),
    c(from =  "S.56 Exemption Letter", to = "Unknown", weight = 1),
    c(from =  "S.56 Exemption Holder Dispensing Tracker", to = "Unknown", weight = 1),
    c(from =  "LD License Including T&C", to = "Unknown", weight = 1),
    c(from =  "NDS 7", to = "Unknown", weight = 1),
    c(from =  "Observation Tracker", to = "Unknown", weight = 1),
    c(from =  "Loss & Theft Report / Suspicious Transactions - PI", to = "Unknown", weight = 1),
    c(from =  "Pharmacy Inspection Tracker", to = "Unknown", weight = 2),
    c(from =  "List of Pharmacies", to = "Unknown", weight = 1),
    
    c(from =  "Community Pharmacy Internal Inspection Report", to = "Database", weight = 1),
    c(from =  "Community Pharmacy Inspection Report", to = "Database", weight = 1),
    c(from =  "Destruction Tracker", to = "Y:// Drive", weight = 1),
    c(from =  "Destruction Application", to = "Y:// Drive", weight = 1),
    c(from =  "Border Center Database", to = "Database", weight = 1)
  
)

pairs_df <- data.frame(t(as.data.frame(pairs)))
rownames(pairs_df) <- NULL

##############################

# Key
label <- unique(c(pairs_df$from,pairs_df$to))
index <- 0:(length(label)-1)
    
    key <- data.frame(
      label = label,
      index = index
    )

pairs_df$from_index <- key$index[match(pairs_df$from, key$label)] 
pairs_df$to_index <- key$index[match(pairs_df$to, key$label)] 

pairs_df$path_name <- paste0("path ", 1:length(pairs_df$from_index))


########################

# Determine origins

origin_name <- pairs_df$from[!(pairs_df$from_index %in% pairs_df$to_index)] 
origin_index <- pairs_df$from_index[!(pairs_df$from_index %in% pairs_df$to_index)]
n_origin <- length(unique(origin_name))

# Determine terminal nodes
terminal_name <- pairs_df$to[!(pairs_df$to %in% pairs_df$from)] 
terminal_index <- pairs_df$to_index[!(pairs_df$to_index %in% pairs_df$from_index)]
n_terminal <- length(unique(terminal_name))

# assign link colour based on origin
col_key_origin <- colorRampPalette(c("#33658A","#86BBD8","#758E4F","#F6AE2D","#F26419"))(n_origin)
col_key_terminal <- colorRampPalette(c("yellow", "red"))(n_terminal)

names(col_key_origin) <- unique(origin_name)
names(col_key_terminal) <- unique(terminal_name)

col_key_links <- adjust_transparency(col = col_key_origin, alpha = 0.6)
names(col_key_links) <- names(col_key_origin)

# initialize origins and colours in df

for(i in 1:nrow(pairs_df)){
  pairs_df$origin[i] <- origin_name[match(pairs_df$from[i], origin_name)]
  pairs_df$origin_id[i] <- origin_index[match(pairs_df$from_index[i], origin_index)]
  pairs_df$link_colour[i] <- col_key_links[match(pairs_df$origin[i], names(col_key_links))]

}

# determine pathways

for(i in 1:nrow(pairs_df)){

next_node <- pairs_df$to_index[i]
origin_node <- pairs_df$origin[i]
origin_id_node <- origin_index[match(origin_node, origin_name)]
origin_colour <- col_key_links[match(origin_node, names(col_key_links))]

pairs_df$origin[which(next_node == pairs_df$from_index[(1:nrow(pairs_df))])] <- origin_node
pairs_df$origin_id[which(next_node == pairs_df$from_index[(1:nrow(pairs_df))])] <- origin_id_node
pairs_df$link_colour[which(next_node == pairs_df$from_index[(1:nrow(pairs_df))])] <- origin_colour

}

# set node colours
pairs_df$node_colour <- substr(pairs_df$link_colour,1,7)

# assign node colours
# all

key$colour <- pairs_df$node_colour[match(key$label, pairs_df$from)]

# terminals
key$colour[which(key$label %in% unique(terminal_name))] <- col_key_terminal[which(names(col_key_terminal) == unique(terminal_name))]


########################

# Compile data

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
    title = "",
    font = list(
      size = 12,
      color = 'black'
    ),
    xaxis = list(showgrid = F, zeroline = F, showticklabels = F),
    yaxis = list(showgrid = F, zeroline = F, showticklabels = F),
    plot_bgcolor = 'white',
    paper_bgcolor = 'white'
  )

p

