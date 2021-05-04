# Move files
# Use helper function (found here: https://stackoverflow.com/questions/10266963/moving-files-between-folders)
my.file.rename <- function(from, to) {
  todir <- dirname(to)
  if (!isTRUE(file.info(todir)$isdir)) dir.create(todir, recursive=TRUE)
  file.rename(from = from,  to = to)
}

# Loop through all files and move them into a new folder
for (i in 1:length(words)) {
  path <- "/Users/cosima/Downloads/latest_keywords/"
  setwd(file.path("/Users/cosima/Downloads/latest_keywords/", words[i]))
  fn <- dir()
  for(j in 1:length(fn)) {
    path_from <- paste0(path, words[i], "/", fn[j])
    path_to <- paste0("/Users/cosima/Downloads/new_keywords_data/", fn[j])
    my.file.rename(from = path_from,
                   to = path_to)
      }
}
