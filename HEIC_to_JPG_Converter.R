# -1- Set working directory to image location -----------------------------------------
setwd("C:/SalGo Research/Datasets/Incomplete Images/TRI - Trinity/TRI1/2024-25")

library(magick)

# -2- Get all HEIC files --------------------------------------------------------------
heic_files <- list.files(pattern = "\\.HEIC$", ignore.case = TRUE)


# -3- Define and create output folder -------------------------------------------------
output_folder <- "TRI202425_JPG"
if (!dir.exists(output_folder)) dir.create(output_folder)


# -4- Function to convert one file ----------------------------------------------------
convert_to_jpg <- function(file) {
  img <- image_read(file)                        # Read HEIC
  img_jpg <- image_convert(img, format = "jpg")  # Convert to JPG
  jpg_file <- file.path(output_folder, paste0(tools::file_path_sans_ext(file), ".jpg"))
  image_write(img_jpg, path = jpg_file)          # Write JPG
  cat("Converted:", file, "->", jpg_file, "\n")
}


# -5- Apply function to all HEIC files ------------------------------------------------
lapply(heic_files, convert_to_jpg)

cat("All files converted!\n")
