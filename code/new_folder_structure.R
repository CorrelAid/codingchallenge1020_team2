# -------------------------------------------------------------------------
# Set up new folder structure
# -------------------------------------------------------------------------
# Version: October 30, 2020 -----------------------------------------------
# -------------------------------------------------------------------------

# -------------------------------------------------------------------------
# Generate new files

# Set up working directory
setwd("~/Downloads/correlaid-zindi/")

dir.create("data")
dir.create("data/audio_augmented")
dir.create("data/audio_train")
dir.create("data/audio_test")
dir.create("data/spectrogram_augmented")
dir.create("data/spectrogram_train")
dir.create("data/spectrogram_test")

# Check what we just created
dir()

# -------------------------------------------------------------------------
# Write a helper function

# Move files
# Use helper function 
# (found here: https://stackoverflow.com/questions/10266963/moving-files-between-folders)
my.file.rename <- function(from, to) {
  todir <- dirname(to)
  if (!isTRUE(file.info(todir)$isdir)) dir.create(todir, recursive=TRUE)
  file.rename(from = from,  to = to)
}


# Generate new csv_files --------------------------------------------------

## For old (new) data
# First get the folder names (="labels")
path <- "/Users/cosima/Downloads/correlaid-zindi/latest_keywords/"
setwd(path)
words <- dir()
# Create an empty data frame
file_names <- data.frame(
)
# Loop through the vector with the "labels" and extend the empty data frame
for (i in 1:length(words)) {
  setwd(file.path("/Users/cosima/Downloads/correlaid-zindi/latest_keywords/", words[i]))
  fn <- dir()
  label <- rep(words[i], length(fn))
  int <- data.frame(cbind(fn, label))
  file_names <- rbind(file_names, int)
}

# Add "audio_train" to fn
file_names$fn <- paste0("audio_train/", file_names$fn)


# -------------------------------------------------------------------------
## Do the same for the new (final) train data
# First get the folder names (="labels")
path <- "/Users/cosima/Downloads/correlaid-zindi/nlp_keywords//"
setwd(path)
words2 <- dir()
# Create an empty data frame
file_names2 <- data.frame(
)
# Loop through the vector with the "labels" and extend the empty data frame
for (i in 1:length(words2)) {
  setwd(file.path("/Users/cosima/Downloads/correlaid-zindi/nlp_keywords/", words2[i]))
  fn <- dir()
  label <- rep(words2[i], length(fn))
  int <- data.frame(cbind(fn, label))
  file_names2 <- rbind(file_names2, int)
}

# Add "audio_train" to fn
file_names2$fn <- paste0("audio_train/", file_names2$fn)

## Combine both
new_names <- rbind(file_names, file_names2)

# Save as a csv file
readr::write_csv(new_names, "/Users/cosima/Downloads/correlaid-zindi/labels_new.csv")


# -------------------------------------------------------------------------

# We might want to combine both the "new_names" file and the "Train.csv" file
train <- read_csv("/Users/cosima/Downloads/correlaid-zindi/Train.csv")

train_full <- rbind(train, new_names)

# Save as a csv file
readr::write_csv(train_full, "/Users/cosima/Downloads/correlaid-zindi/train_full.csv")

# -------------------------------------------------------------------------

# Set up train data -------------------------------------------------------

# New train data
setwd("/Users/cosima/Downloads/correlaid-zindi/latest_keywords/")

words <- list.files()

# Loop through all files and move them into a new folder
for (i in 1:length(words)) {
  path <- "/Users/cosima/Downloads/correlaid-zindi/latest_keywords/"
  setwd(file.path("/Users/cosima/Downloads/correlaid-zindi/latest_keywords/", words[i]))
  fn <- dir()
  for(j in 1:length(fn)) {
    path_from <- paste0(path, words[i], "/", fn[j])
    path_to <- paste0("/Users/cosima/Downloads/correlaid-zindi/data/audio_train/", fn[j])
    my.file.rename(from = path_from,
                   to = path_to)
  }
}

# Old train data (only move train data but keep test data)

setwd("/Users/cosima/Downloads/correlaid-zindi/audio_files/")
train <- read_csv("/Users/cosima/Downloads/correlaid-zindi/Train.csv")
files <- str_replace(train$fn, "audio_files/", "")

for(j in 1:length(files)) {
  path_from <- paste0("/Users/cosima/Downloads/correlaid-zindi/audio_files/", files[j])
  path_to <- paste0("/Users/cosima/Downloads/correlaid-zindi/data/audio_train/", files[j])
  my.file.rename(from = path_from,
                 to = path_to)
}


# Add our newest (and final) train data -----------------------------------

setwd("/Users/cosima/Downloads/correlaid-zindi/nlp_keywords/")

words2 <- list.files()

# Loop through all files and move them into a new folder
for (i in 1:length(words2)) {
  path <- "/Users/cosima/Downloads/correlaid-zindi/nlp_keywords/"
  setwd(file.path("/Users/cosima/Downloads/correlaid-zindi/nlp_keywords/", words2[i]))
  fn2 <- dir()
  for(j in 1:length(fn2)) {
    path_from <- paste0(path, words2[i], "/", fn2[j])
    path_to <- paste0("/Users/cosima/Downloads/correlaid-zindi/data/audio_train/", fn2[j])
    my.file.rename(from = path_from,
                   to = path_to)
  }
}

# Set up test data --------------------------------------------------------

# Move remaining data in "audio_files 2"

setwd("/Users/cosima/Downloads/correlaid-zindi/audio_files/")

test_data <- list.files()

for(j in 1:length(test_data)) {
  path_from <- paste0("/Users/cosima/Downloads/correlaid-zindi/audio_files/", test_data[j])
  path_to <- paste0("/Users/cosima/Downloads/correlaid-zindi/data/audio_test/", test_data[j])
  my.file.rename(from = path_from,
                 to = path_to)
}


