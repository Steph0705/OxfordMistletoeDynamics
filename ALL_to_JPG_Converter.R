## HEIC/PNG TO JPG CONVERTER ##
# This code allows the user to convert a file containing .HEIC images to .JPG images,
# and outputs a folder containing .JPG images next to the .HEIC images.

library(magick)
library(rstudioapi)   # provides function to let user pick directory
library(svDialogs)   # provides function to construct dialog boxes for GUI

# -1- Ask user to pick the folder  --------------------------------------------------------
wd <- selectDirectory(caption = "Select the folder containing your chosen images:")
setwd(wd)


# -2- Allow user to select HEIC or PNG to convert  ----------------------------------------
png_or_heic <- dlg_list(c("HEIC", "PNG"), title = "Choose format to convert to JPG")$res


###########################################################################################

if (png_or_heic == "HEIC") {
  cat("You chose HEIC\n")
  
  # -2.1- Get all HEIC files --------------------------------------------------------------
  heic_files <- list.files(pattern = "\\.HEIC$", ignore.case = TRUE)
  
  
  # -2.2- Define and create output folder -------------------------------------------------
  output_folder <- "HEIC_to_JPG"
  if (!dir.exists(output_folder)) dir.create(output_folder)
  
  
  # -2.3- Function to convert one file ----------------------------------------------------
  convert_to_jpg <- function(file) {
    img <- image_read(file)                        # Read HEIC
    img_jpg <- image_convert(img, format = "jpg")  # Convert to JPG
    jpg_file <- file.path(output_folder, paste0(tools::file_path_sans_ext(file), ".jpg"))
    image_write(img_jpg, path = jpg_file)          # Write JPG
    cat("Converted:", file, "->", jpg_file, "\n")
  }
  
  
  # -2.4- Apply function to all HEIC files ------------------------------------------------
  lapply(heic_files, convert_to_jpg)
  
  cat("All files converted!\n")
  
###########################################################################################
  
} else if (png_or_heic == "PNG") {
  cat("You chose PNG\n")
  
  # -2.1- Get all .PNG files --------------------------------------------------------------
  png_files <- list.files(pattern = "\\.PNG$", ignore.case = TRUE)
  
  
  # -2.2- Define and create output folder -------------------------------------------------
  output_folder <- "PNG_to_JPG"
  if (!dir.exists(output_folder)) dir.create(output_folder)
  
  
  # -2.3- Function to convert one file ----------------------------------------------------
  convert_to_jpg <- function(file) {
    img <- image_read(file)                        # Read PNG
    img_jpg <- image_convert(img, format = "jpg")  # Convert to JPG
    jpg_file <- file.path(output_folder, paste0(tools::file_path_sans_ext(file), ".jpg"))
    image_write(img_jpg, path = jpg_file)          # Write JPG
    cat("Converted:", file, "->", jpg_file, "\n")
  }
  
  
  # -2.4- Apply function to all HEIC files ------------------------------------------------
  lapply(png_files, convert_to_jpg)
  
  cat("All files converted!\n")
  
###########################################################################################
  
} else {
  cat("Invalid input. Please enter 'HEIC' or 'PNG'.\n")
}
