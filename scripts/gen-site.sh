#!/bin/bash
# Copyright (c) 2025 Pregnancy Aid of Washington State.
# This individual file is licensed under the "GNU Affero General Public License v3.0".
# Refer to agpl-notice.txt, agpl-3.0.txt, and https://www.gnu.org/licenses/ for details.

# Generate static site files from source files

set -eu

src="./src"
dest="./gen"

rm -rf "$dest"
mkdir -p "$dest"

# Copy all files from src to dest, one line at a time, substiting `<!--#include file=` lines
copy-file() {
    local infile="$1"
    local outfile="$2"
    local relative_ref="${3:-.}" # e.g. . or ..

    local extension="${infile##*.}"
    if [[ "$extension" != "shtml" && "$extension" != "html" ]]; then
        # just copy the file
        cp "$infile" "$outfile"
        return
    fi

    local line
    while IFS= read -r line; do
        # remove BOM if present
        line="${line//$'\uFEFF'/}"

        if [[ $line =~ $SSI_REGEX ]]; then
            local include_file="${BASH_REMATCH[2]}"
            local include_dir="$(dirname "$include_file")" # e.g. . or ..
            local base_dir="$(dirname "$infile")"
            echo "- including $base_dir/$include_file into $outfile ($include_dir)"
            copy-file "$base_dir/$include_file" "$outfile" "$include_dir"
            continue
        fi

        if [[ $line =~ $SHTML_HREF_REGEX ]]; then
            local href="${BASH_REMATCH[1]}"
            echo "- rewriting $href.shtml to $href.html in $outfile"
            line="${line//$href.shtml/$href.html}"
        fi

        if [[ $relative_ref != "." && $line =~ $RELATIVE_REF_REGEX ]]; then
            # for an ssi include file that is being included into a file from a subdir,
            # we need to adjust the relative references of the ssi include file
            echo "- rewriting relative reference for ${BASH_REMATCH[2]} in $outfile"
            line="${line//${BASH_REMATCH[1]}=\".\//${BASH_REMATCH[1]}=\"$relative_ref/}"
        fi

        echo "$line" >> "$outfile"
    done < "$infile"
}
SSI_REGEX='<!--#include (file|virtual)="([^"]+)" *-->'
SHTML_HREF_REGEX='href="([^"]+)\.shtml"'
RELATIVE_REF_REGEX='(href|src)="(\./[^"]*)"'


# process all files in $src, including subdirectories
find "$src" -type f | while read -r file; do
    echo "processing $file"
    rel_path="${file#$src/}"
    filename="$(basename "$file")"

    # Skip files starting with underscore
    if [[ "$filename" == _* ]]; then
        echo "- skipping $file"
        continue
    fi

    # rename *.shtml to *.html
    if [[ "$filename" == *.shtml ]]; then
        rel_path="${rel_path%.shtml}.html"
    fi

    out_file="$dest/$rel_path"
    out_dir="$(dirname "$out_file")"
    mkdir -p "$out_dir"
    > "$out_file"  # create or empty the output file
    echo "generating $out_file"
    copy-file "$file" "$out_file"
done
echo "Site generated in $dest"
