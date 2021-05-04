library(magrittr)

# Move data in the folder type that is required for data loader

setwd("~/Downloads/correlaid-zindi/")

dir.create("data_new_order/")
dir.create("data_new_order/audio_train")
dir.create("data_new_order/audio_test")
dir.create("data_new_order/audio_augmented")
dir.create("data_new_order/spectrogram_augmented")
dir.create("data_new_order/spectrogram_train")

dir()

# -------------------------------------------------------------------------
## First: Deal with train data

# Get full train data
train_data <- readr::read_csv("train_full.csv")
train_data$fn <- stringr::str_remove(train_data$fn, "audio_files/")
train_data$fn <- stringr::str_remove(train_data$fn, "audio_train/")

# Get unique labels
train_label <- unique(train_data$label)

# Generate new folders with the unique label
for (i in train_label) {
  dir.create(paste0("data_new_order/audio_train/", i))
}

# Now move files to the folders
# Use helper function 
# (found here: https://stackoverflow.com/questions/10266963/moving-files-between-folders)
my.file.rename <- function(from, to) {
  todir <- dirname(to)
  if (!isTRUE(file.info(todir)$isdir)) dir.create(todir, recursive=TRUE)
  file.rename(from = from,  to = to)
}


# Loop through all files and move them into a new folder
for (i in 1:nrow(train_data)) {
 # for (j in train_label) {
    # if (isTRUE(train_label[j] == train_data$label[i])) {
      path_from <-
        paste0(
          "/Users/cosima/Downloads/data/audio_train/",
          train_data$fn[i]
        )
      path_to <-
        paste0("/Users/cosima/Downloads/correlaid-zindi/data_new_order/audio_train/",
               train_data$label[i], "/", train_data$fn[i])
      my.file.rename(from = path_from,
                     to = path_to)
    # }
#  }
}


# Second: For the augmented data ---------------------------------------------

augmented <- readr::read_csv("train_augmented_data.csv")

augmented %<>% 
  dplyr::select(-X1)

augmented$fn <- stringr::str_remove(augmented$fn, "audio_train/aug-speed-")
augmented$fn <- stringr::str_remove(augmented$fn, "audio_train/aug-pitch-")
augmented$fn <- stringr::str_remove(augmented$fn, "audio_train/aug-noise-")
augmented$fn <- stringr::str_remove(augmented$fn, "audio_train/aug-shift-")

# Get unique labels
augmented_label <- unique(augmented$label)

# Generate new folders with the unique label
for (i in augmented_label) {
  dir.create(paste0("data_new_order/audio_augmented/", i))
}

# Loop through all files and move them into a new folder
# For pitch
for (i in 1:nrow(augmented)) {
  path_from <-
    paste0(
      "/Users/cosima/Downloads/data/audio_augmented/pitch/aug-pitch-",
      augmented$fn[i]
    )
  path_to <-
    paste0("/Users/cosima/Downloads/correlaid-zindi/data_new_order/audio_augmented/",
           augmented$label[i], "/", augmented$fn[i])
  my.file.rename(from = path_from,
                 to = path_to)
}

# For speed
for (i in 1:nrow(augmented)) {
  path_from <-
    paste0(
      "/Users/cosima/Downloads/data/audio_augmented/speed/aug-speed-",
      augmented$fn[i]
    )
  path_to <-
    paste0("/Users/cosima/Downloads/correlaid-zindi/data_new_order/audio_augmented/",
           augmented$label[i], "/", augmented$fn[i])
  my.file.rename(from = path_from,
                 to = path_to)
}

# For shift
for (i in 1:nrow(augmented)) {
  path_from <-
    paste0(
      "/Users/cosima/Downloads/data/audio_augmented/shift/aug-shift-",
      augmented$fn[i]
    )
  path_to <-
    paste0("/Users/cosima/Downloads/correlaid-zindi/data_new_order/audio_augmented/",
           augmented$label[i], "/", augmented$fn[i])
  my.file.rename(from = path_from,
                 to = path_to)
}

# For noise
for (i in 1:nrow(augmented)) {
  path_from <-
    paste0(
      "/Users/cosima/Downloads/data/audio_augmented/noise/aug-noise-",
      augmented$fn[i]
    )
  path_to <-
    paste0("/Users/cosima/Downloads/correlaid-zindi/data_new_order/audio_augmented/",
           augmented$label[i], "/", augmented$fn[i])
  my.file.rename(from = path_from,
                 to = path_to)
}

# Third: For the test data -----------------------------------------------

test <- readr::read_csv("SampleSubmission.csv")


# Fourth: Spectrogram test ------------------------------------------------

# Generate new folders with the unique label
for (i in train_label) {
  dir.create(paste0("data_new_order/spectrogram_train/", i))
}

train_data$fn <- stringr::str_remove(train_data$fn, ".wav")

# Loop through all files and move them into a new folder
for (i in 1:nrow(train_data)) {
  path_from <-
    paste0(
      "/Users/cosima/Downloads/data/spectrogram_train/",
      train_data$fn[i], "-spectrogram.png"
    )
  path_to <-
    paste0("/Users/cosima/Downloads/correlaid-zindi/data_new_order/spectrogram_train/",
           train_data$label[i], "/", train_data$fn[i], "-spectrogram.png")
  my.file.rename(from = path_from,
                 to = path_to)
}


# Fifth: Generate overview of labels for spectrograms augmented -----------

# Get unique labels
train_label <- unique(train_data$label)

# Generate new folders with the unique label
for (i in train_label) {
  dir.create(paste0("~/Downloads/data_new_order/spectrogram_augmented/", i))
}


