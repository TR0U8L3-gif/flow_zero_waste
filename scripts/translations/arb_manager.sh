#!/bin/bash

# Function to print usage instructions
print_info() {
    echo "Usage: $0 -paths <input-file-path> <input-file-to-apply-changes-path>"
    echo
    echo "Flags:"
    echo "-paths: specify the paths of the input files to compare"
    echo "-raw: output the differences in raw JSON format (default pretty)"
    echo "-sort: output sorted files (default no sort)"
    echo "-diff: output differences file (default no diff)"
    echo "-apply_changes: apply the changes from the diff file to the old file"
    echo
    echo "Alternative usage: $0 -sort <input-catalog-path>"
    echo "-sort: sort the contents of the ARB files in the catalog"
    echo "-raw: output the differences in raw JSON format (default pretty)"
    echo
    echo "Warning: remember to install jq before running this script."
    echo "You can install jq using the following command:"
    echo "linux: sudo apt-get install jq"
    echo "macos: brew install jq"
    echo "windows: curl -L -o /usr/bin/jq.exe https://github.com/jqlang/jq/releases/latest/download/jq-win64.exe"
}

# Function to sort JSON file contents and output to a new file
sort_arb_file() {
    input_file=$1
    output_dir=$2

    # Create the output directory if it doesn't exist
    if [ ! -d "$output_dir" ]; then
        mkdir -p "$output_dir"
    fi

    sorted_file="${output_dir}/$(basename "$input_file")"
    jq -S '.' "$input_file" > "$sorted_file"
    echo "Sorted $input_file -> $sorted_file"
}

# Function to compare two JSON files and output differences
compare_arb_files() {
    file1=$1
    file2=$2
    diff_file=$3
    pretty=$4

    # Extract keys that are in file2 but not in file1 (added)
    added=$(jq --slurpfile file1 "$file1" --slurpfile file2 "$file2" -n '($file2[0] | keys - ($file1[0] | keys)) as $add | reduce $add[] as $key ({}; . + {($key): $file2[0][$key]})')

    # Extract keys that are in file1 but not in file2 (removed)
    removed=$(jq --slurpfile file1 "$file1" --slurpfile file2 "$file2" -n '($file1[0] | keys - ($file2[0] | keys)) as $rem | reduce $rem[] as $key ({}; . + {($key): $file1[0][$key]})')

    # Extract keys that exist in both but have modified values
    modified=$(jq --slurpfile file1 "$file1" --slurpfile file2 "$file2" -n '
        ($file1[0] | keys) as $keys |
        reduce $keys[] as $key ({}; 
            if ($file1[0][$key] != $file2[0][$key]) and ($file2[0] | has($key)) then 
                . + {($key): {old: $file1[0][$key], new: $file2[0][$key]}} 
            else . end
        )
    ')

    # Combine all differences
    differences=$(jq -n --argjson added "$added" --argjson removed "$removed" --argjson modified "$modified" '{
        added: $added,
        removed: $removed,
        modified: $modified
    }')

    # Output the differences
    if [ "$pretty" = true ]; then
        echo "$differences" | jq .
    else
        echo "$differences"
    fi

    # Save the differences to a diff file if specified
    if [ -n "$diff_file" ]; then
        echo "$differences" > "$diff_file"
        echo "Differences saved to $diff_file"
    fi
}

# TODO: fix the apply_changes_to_file function
# Function to apply changes from diff to the old file
apply_changes_to_file() {
    input_file=$1
    diff_file=$2
    output_file=$3
    pretty=$4

    updated_content=$(jq --argfile diff "$diff_file" '. * $diff' "$input_file")

    if [ "$pretty" = true ]; then
        echo "$updated_content" | jq . > "$output_file"
    else
        echo "$updated_content" > "$output_file"
    fi

    echo "Changes applied to $output_file"
}

# Function to check if a flag is set
is_flag_set() {
    flag=$1
    shift
    for arg; do
        if [ "$arg" == "$flag" ]; then
            return 0
        fi
    done
    return 1
}

# Main script logic
if [ "$#" -lt 1 ]; then
    print_info
    exit 1
fi

# Default settings
pretty=true

# Parse arguments
while [ "$#" -gt 0 ]; do
    case "$1" in
        -help)
            print_info
            exit 0
            ;;
        -paths)
            input_file1=$2
            input_file2=$3
            shift 3
            ;;
        -raw)
            pretty=false
            shift
            ;;
        -sort)
            if [ "$#" -ge 2 ]; then
                input_catalog_path=$2
                shift 2
            else
                echo "Error: Missing input catalog path for sorting."
                exit 1
            fi
            ;;
        -diff)
            diff_file="diff_output.json"
            shift
            ;;
        -apply_changes)
            apply_changes=true
            shift
            ;;
        *)
            echo "Unknown flag: $1"
            print_info
            exit 1
            ;;
    esac
done

# Sort files if the -sort flag is set
if [ -n "$input_catalog_path" ]; then
    for file in "$input_catalog_path"/*.arb; do
        sort_arb_file "$file" "$input_catalog_path/sorted_catalog"
    done
fi

# Compare and diff files if -paths is set
if [ -n "$input_file1" ] && [ -n "$input_file2" ]; then
    compare_arb_files "$input_file1" "$input_file2" "$diff_file" "$pretty"
fi

# Apply changes from the diff file if -apply_changes flag is set
if [ "$apply_changes" = true ] && [ -n "$diff_file" ]; then
    apply_changes_to_file "$input_file2" "$diff_file" "$input_file2" "$pretty"
fi
