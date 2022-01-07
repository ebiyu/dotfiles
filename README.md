# dotfiles

## install

```sh
curl -sSL dot.ebiyuu.com | sh
```

githubへのssh接続が設定されていれば、sshを用いてcloneします。

sshが設定されていなければ、httpsでcloneします。

## cron

以下をcronに設定すると、定期的に自動で同期します。

```
0 * * * * /path/to/home/dir/dotfiles/bin/dotfiles cron
```

## command

```sh
dotfiles link # setup symlinks
dotfiles sync # sync with repo and setup symlinks
dotfiles vi # open dotfiles directory in vim
dotfiles code # open dotfiles directory in VSCode
```

