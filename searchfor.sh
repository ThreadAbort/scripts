#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <directory> <search_term> <context_length>"
    exit 1
fi

DIRECTORY=$1
SEARCH_TERM=$2
CONTEXT_LENGTH=$3

# Ensure context length is a valid number
if ! [[ "$CONTEXT_LENGTH" =~ ^[0-9]+$ ]]; then
    echo "Context length must be a valid number"
    exit 1
fi

# Calculate half of the context length
HALF_CONTEXT=$((CONTEXT_LENGTH / 2))

# Function to perform the search and limit output to the specified context
function search_with_context() {
    grep -rH "$SEARCH_TERM" "$DIRECTORY" 2>&1 | grep -v "Permission denied" | grep -v "Invalid argument" | awk -v term="$SEARCH_TERM" -v context="$HALF_CONTEXT" '{
        match($0, term);
        start=RSTART-context;
        if (start < 1) start=1;
        end=RSTART+RLENGTH+context-1;
        if (end > length($0)) end=length($0);
        print substr($0, 1, index($0, ":")) substr($0, start, end-start+1);
    }'
}

# Run the search function
search_with_context
