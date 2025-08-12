### Oxford Tree Heights
### 2025.08.12
### Oliver G. Spacey

# Script to calculate estimate of tree heights for each tree and output a .csv for each subset

# Clear environment
rm(list = ls())

# Set working directory

# Load required packages
library(tidyverse)

# Load data ---------------------------------------------------------------
# Load entire dataset
oxford_trees_df <- read.csv("Oxford_Trees_Long.csv")

# Wrangle data ------------------------------------------------------------
# Select relevant columns - TreeID and Height
ID_ht_df <- select(oxford_trees_df, TreeID, Height_Tri)

# Define subset string
sub_str <- "TRI"

# Select relevant rows
subset_df <- filter(ID_ht_df, grepl(sub_str, TreeID))

# Convert heights to numeric variable
subset_df$Height_Tri <- as.numeric(subset_df$Height_Tri)

# Calculate mean height for each tree
means_df <- subset_df %>%
            group_by(TreeID) %>%
            summarise(Height = mean(Height_Tri, na.rm = TRUE)) %>%
            # Rename TreeID to TreeCode for compatibility with ImageJ macro
            rename(TreeCode = TreeID)

# Export data -------------------------------------------------------------
# Create file name
csv_name <- paste(sub_str, "Heights.csv", sep = "_")

# Write .csv 
write.csv(means_df, file = csv_name)
