# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/), packages
provisioned with a local Ansible playbook. Replaces the old per-tool repos
(`nvim-config`, `fish-config`, `wezterm-config`, `opencode-config`) — their
history is preserved here via `git subtree`.

Not in this repo (by design): secrets and live data stay in Syncthing
(`~/Sync/configs/`: ssh keys, KeePass, passkeys, atuin backups).

## Fresh PC

```sh
git clone git@github.com:dratasich/dotfiles.git ~/repos/dotfiles
~/repos/dotfiles/bootstrap.sh personal
```

The script provisions from the clone it lives in.

Then start Syncthing and wait for `~/Sync` (KeePass, SSH keys).

Package scope: core CLI only (git, editor, shell, terminal, cli-tools,
keepassxc, syncthing). IDEs, docker, language runtimes: manual, see
`Sync/configs/install/*.install`.

## Layout

- `dot_config/` — chezmoi source for `~/.config` (editor, shell, terminal, ai-agent)
- `.chezmoi.toml.tmpl` — per-machine data, values come from `provision/vars/<profile>.yml` (`bootstrap.sh [personal|work]`)
- `bootstrap.sh` — distro detect, install git+ansible, run playbook
- `provision/` — Ansible (localhost): packages, shell, syncthing unit,
  `chezmoi init --apply`

## Daily use

```sh
chezmoi edit ~/.config/fish/config.fish   # edit via chezmoi
chezmoi diff                              # what would change
chezmoi apply                             # apply
chezmoi cd && git add -A && git commit    # persist
```
