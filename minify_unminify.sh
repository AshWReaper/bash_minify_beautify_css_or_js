#!/bin/bash

# Function to check if a command exists
command_exists() {
    type "$1" &> /dev/null
}

# Check for required commands
for cmd in postcss uglifyjs js-beautify; do
    if ! command_exists $cmd; then
        echo "Command not found: $cmd"
        if [ "$cmd" = "uglifyjs" ]; then
            echo "Please install it using npm (e.g., npm install -g uglify-js)"
        else
            echo "Please install it using npm (e.g., npm install -g $cmd)"
        fi
        exit 1
    fi
done

# Check if a file is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

# Check if the provided file exists
if [ ! -f "$1" ]; then
    echo "File not found: $1"
    exit 1
fi

filename=$1
extension="${filename##*.}"
basename="${filename%.*}"

# Ask if user wants to generate a source map
echo "Generate source map? (yes/no):"
read generate_map
generate_map_flag=""
if [ "$generate_map" = "yes" ]; then
    generate_map_flag="--map inline"
fi

# Determine the tool based on file extension
case "$extension" in
    css)
        minify_tool="postcss $filename --use cssnano $generate_map_flag -o"
        unminify_tool="js-beautify --css $filename >"
        ;;
    js)
        if [ "$generate_map" = "yes" ]; then
            minify_tool="uglifyjs $filename --source-map \"url='$basename.min.js.map'\" -o"
        else
            minify_tool="uglifyjs $filename -o"
        fi
        unminify_tool="js-beautify --js $filename >"
        ;;
    *)
        echo "Unsupported file type: $extension"
        exit 1
        ;;
esac

# Ask user for action (minify or unminify)
echo "Do you want to minify or unminify the file? Enter 'minify' or 'unminify':"
read action

case "$action" in
    minify)
        output_file="${basename}.min.${extension}"
        eval $minify_tool "$output_file"
        ;;
    unminify)
        output_file="${basename}.unmin.${extension}"
        eval $unminify_tool "$output_file"
        ;;
    *)
        echo "Invalid action: $action"
        exit 1
        ;;
esac

echo "Output file generated: $output_file"
