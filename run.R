source("functions.R")


# Set directory paths.
destPath = "../processed/" # Where to save the resulting file.
rootPath = "../OBF/" # Path where the dataset is located.

# Extract features.
extract.features(rootPath, destPath, "control")
extract.features(rootPath, destPath, "depression")
extract.features(rootPath, destPath, "schizophrenia")

# Merge feature files.
merge.features(destPath)
