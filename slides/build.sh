#!/bin/zsh

usage() {
    echo "usage: build.sh <markdown_file>"
}

build() {
    if [[ -z "$1" ]]; then
        usage
        return 1
    fi

    md_doc="$1"
    # get full path to header.tex (prone to bugs/could be better)
    pandoc --standalone --filter=pandoc-citeproc \
           --from=markdown --to=beamer \
           --latex-engine=xelatex -H header.tex \
           --highlight-style breezedark \
           --output="${md_doc%.*}.pdf" "$md_doc" \
        || echo "pandoc error ..."
}

build $@
