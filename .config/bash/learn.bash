for file in ./*; do echo $file | awk -F/ '{print $2}' | awk -F. '{print $1}' | xargs -I '{}' mv $file {}.wiki;done
