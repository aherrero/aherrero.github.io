ls | grep JPG | cat -n | while read n f; do mv "$f" "$n.JPG"; done
