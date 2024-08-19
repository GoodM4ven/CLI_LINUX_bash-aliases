#!/bin/bash

# Credits: ChatGPT-4o

# Check if any argument is provided
if [ "$#" -eq 0 ]; then
  echo "Please provide Arabic text as input."
  exit 1
fi

# Join all arguments into a single string
input="$@"

# Remove Tashkeel from the Arabic text
# The following characters represent common Tashkeel in Arabic: َ ً ُ ٌ ِ ٍ ْ ّ

output=$(echo "$input" | sed -e 's/[ًٌٍَُِّْ]//g')

echo "$output"
