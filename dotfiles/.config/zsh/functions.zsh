function fixspaces() {
    # replace spaces in filenames with underscores
    for file in *' '*; 
        do mv -- "$file" "${file// /_}"; 
    done
}


