# AstroNvim Template

**NOTE:** This is for AstroNvim v4+

A template for getting started with [AstroNvim](https://github.com/AstroNvim/AstroNvim)

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Create a new user repository from this template

Press the "Use this template" button above to create a new repository to store your user configuration.

You can also just clone this repository directly if you do not want to track your user configuration in GitHub.

#### Clone the repository

```shell
git clone https://github.com/<your_user>/<your_repository> ~/.config/nvim
```

#### Spell file configuration

```sh
mkdir -p ~/.dotfiles.git/.config/${NVIM_APPNAME:-astronvim}/spell
touch ~/.dotfiles.git/.config/${NVIM_APPNAME:-astronvim}/spell/en.utf-8.add
nvim --headless -c "set spell" -c "qall"
nvim --headless -c "set spellfile=~/.config/${NVIM_APPNAME:-astronvim}/spell/en.utf-8.add" -c "qall"
nvim --headless -c "mkspell! ~/.config/${NVIM_APPNAME:-astronvim}/spell/en.utf-8.add" -c "qall"
nvim --headless -c "echo &spellfile" -c "echo &spelllang" -c "echo &spell" -c "qall"
nvim --headless -c "spellgood astronvim" -c "qall"
```

#### Start Neovim

```shell
nvim
```

```

```
