#!/usr/bin/env bash
set -euo pipefail
git config --global grep.extendRegexp true
git config --global grep.lineNumber true
rm -f results.txt
total_usage_count=()

field_names=$(grep -Ei "^\s*t\.(integer|string|text|boolean|date|bigint|binary|decimal|virtual)" db/schema.rb |
cut -f1 -d',' |
cut -f2 -d'"' |
sort -u)

for i in $field_names; do
  # Get the usage count in each file
  uses_count=$(git grep -Ec "$i")
  num_count=0
  # Parse the count for each file and append to count
  for j in $uses_count; do
    num_count=$(($num_count + $(echo "$j" | grep -o -E '[0-9]+')))
  done
  total_usage_count+=("$num_count $i")

  # Insert the column name and its usage count into the results file
  echo "$i - $num_count occurrence(s) - $uses_count" >> results.txt
  uses=$(git grep -Ei "$i")
  IFS=$'\n'
  # Insert each use of the column name into the results file
  for use in $uses; do
    echo "  $use" >> results.txt
  done
done

IFS=$'\n'
sorted_counts=($(sort -nf -k1 <<<"${total_usage_count[*]}"));

echo "Uses Column"
for value in "${sorted_counts[@]}"; do
  echo "$value"
done
