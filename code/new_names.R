# First get the folder names (="labels")
path <- "/Users/cosima/Downloads/latest_keywords"
setwd(path)
words <- dir()
# Create an empty data frame
file_names <- data.frame(
)
# Loop through the vector with the "labels" and extend the empty data frame
for (i in 1:length(words)) {
  setwd(file.path("/Users/cosima/Downloads/latest_keywords/", words[i]))
  fn <- dir()
  label <- rep(words[i], length(fn))
  int <- data.frame(cbind(fn, label))
  file_names <- rbind(file_names, int)
}

# Add "audio_files2" to fn
file_names$fn <- paste0("audio_files2/", file_names$fn)

# Save as a csv file
readr::write_csv(file_names, "/Users/cosima/Downloads/labels_new.csv")
