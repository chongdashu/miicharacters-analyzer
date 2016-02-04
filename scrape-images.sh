#!/bin/bash

prefix="http://www.miicharacters.com/"

while IFS='' read -r line || [[ -n "$line" ]]; do
    url=$prefix$line
    echo "Scraping " $url
    
    # Ref: http://stackoverflow.com/a/23672183/2669714
    # line: miis/large/2846_joshturner.jpg
    IFS='/' read -a myarray <<< "$line"
    filename=${myarray[2]}
    echo "filename: ${filename}"

    IFS="_" read -a myarray <<< "${filename}"
    id=${myarray[0]}
    name=${myarray[1]}

    echo "id: ${id}"
    echo "name: ${name}"
    
    # START SLEEP
    t=$(( ( RANDOM % 5 )  + 1 ))
    echo Sleeping for $t
    sleep ${t}s
    m=$((id%10))
    # - END SLEEP
    
    if [ ! -d images/$m/$id ]; then
        mkdir -p images/$m
    fi;
    wget $url -O images/$m/${filename}
    cp images/$m/${filename} images/$m/${id}.jpg

# Use this to pass an argument
# done < "$1"
# Use this as a hard-code
done < "image_urls.txt"
