# dotfiles

This project is managed by [chezmoi](https://www.chezmoi.io/).

## requirement

## install

```sh
curl -sSL dot.ebiyuu.com | sh
```

This runs steps below.

1. Download/install chezmoi to your computer.
2. Clone this repository and place dotfiles by chezoi.
3. [afx](https://github.com/b4b4r07/afx) is installed by chezmoi.
4. Some commnand line tool (including nvim) is installed by afx.


This clones this repository by http.
If you want to push to this repository, please run:

```sh
git remote set-url origin git@github.com:ebiyuu1121/dotfiles

```

## daily tasks

```sh
chezmoi update
chezmoi apply

chezmoi edit -a # open nvim on directory
chezmoi edit -a {file}
```

