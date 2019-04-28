mkdir -p renamed
ls | grep jpg | cat -n | while read n f; do mv "$f" "renamed/$n.jpg"; done
