for filename in $(fd '.*\.(html|svg|css|js|xml)' $1); do
    minify $filename | gzip > $filename.gz
    touch $filename $filename.gz
done
