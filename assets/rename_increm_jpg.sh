mkdir -p renamed
ls | grep JPG | cat -n | while read n f; do mv "$f" "renamed/$n.jpg"; done
