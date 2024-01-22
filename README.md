# Minify-Unminify Script

## Description
This Bash script allows users to easily minify or unminify JavaScript and CSS files. It provides an interactive command-line interface to process files and supports optional source map generation for CSS files.

## Requirements
- Bash
- Node.js and npm
- The following npm packages globally installed:
  - `uglify-js` for JavaScript minification
  - `js-beautify` for JavaScript and CSS unminification
  - `postcss-cli` and `cssnano` for CSS minification

## Installation

First, ensure that Node.js and npm are installed on your system. Then, install the required npm packages globally:

```bash
npm install -g uglify-js js-beautify postcss-cli cssnano
```

## Usage
Run the script from the command line, passing in the file you wish to process:
```bash
./minify_unminify.sh <filename>
```

The script will prompt you to choose between minifying and unminifying the file. For CSS files, you will also be asked if you want to generate a source map.

The output will be saved in the same directory as the input file with a modified filename indicating the operation performed (e.g., file.min.js for minified files).

## Output File Naming Convention
Minified JavaScript/CSS files: <original-filename>.min.js or <original-filename>.min.css
Unminified JavaScript/CSS files: <original-filename>.unmin.js or <original-filename>.unmin.css

## Notes
The script checks for the required npm packages and prompts for installation if any are missing.
It is recommended to use this script in a development environment. Always keep a backup of your original files.
