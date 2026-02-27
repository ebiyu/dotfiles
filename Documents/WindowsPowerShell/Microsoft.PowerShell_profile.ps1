Invoke-Expression (&starship init powershell)

function repo() {
 $repository =  $(ghq list | peco)
 $repositoryPath = (ghq root) + '/' + $repository
 cd $repositoryPath
}

