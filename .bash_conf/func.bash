proj(){
    if [ -e "$HOME/projects" ]; then
        cd "$HOME/projects"
    else
        if [ -e "$HOME/Documents/projects" ]; then
            cd "$HOME/Documents/projects/"
        else
            echo "no project directory"
        fi
    fi
}
