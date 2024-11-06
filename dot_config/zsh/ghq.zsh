# ghq setup
function peco-ghq () {
  #local selected_dir=$(ghq list -p | fzf --preview "cat {}/README.*")
  #local selected_dir=$(ghq list -p | fzf --preview "tree -L 1 {}")
  local selected_dir=$(ghq list -p | fzf --preview "cd {} && git log")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N peco-ghq
bindkey '^]' peco-ghq

#alias gcd='cd $(ghq root)/`ghq list |fzf --preview "cat $(ghq root)/{}/README.*"`'
