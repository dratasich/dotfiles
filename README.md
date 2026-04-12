# fish-config

Basic fish-config for all of my machines.

## Installation

```bash
ln -s ~/repos-utils/fish-config/config.fish ~/.config/fish/config.fish
# without overriding potentially existing `conf.d` files from installed packages
ln -s ~/repos-utils/fish-config/conf.d/* ~/.config/fish/conf.d/
```

Install [`fisher`](https://github.com/jorgebucaran/fisher) for plugins.

### Theme

```bash
fisher install oh-my-fish/theme-bobthefish
```

### Completions

```bash
fisher install evanlucas/fish-kubectl-completions
```

### Other

```bash
# get nvm to work in fish
fisher install jorgebucaran/nvm.fish
```
