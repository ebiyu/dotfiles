Invoke-Expression (&starship init powershell)

function rep() {
 $repository =  $(ghq list | peco)
 $repositoryPath = (ghq root) + '/' + $repository
 cd $repositoryPath
}

