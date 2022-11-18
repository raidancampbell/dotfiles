for FN in ~/.zsh/modules/* ; do
#  to enable more human-readable per-module times, uncomment the below
#    timer=$(($(gdate +%s%N)/1000000))
    source "$FN"
#    now=$(($(gdate +%s%N)/1000000))
#    elapsed=$(($now-$timer))
#    echo $elapsed":" $FN
done