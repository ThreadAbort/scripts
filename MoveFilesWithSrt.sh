#!/bin/bash

# Loop through all .srt files in the current directory
for srt_file in *.srt; do
    echo $srt_file
    # Extract the base name without the extension
    base_name=$(basename "$srt_file" .srt)
    echo $base_name


    # Create a directory with the base name if it doesn't already exist
    mkdir -p "srt_$base_name"

    # Move all files that start with the base name into the directory
    mv "${base_name}"* "srt_$base_name"/
done
