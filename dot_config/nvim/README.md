# nvim-config

Copied from the starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Setup

1. Install [Neovim](https://neovim.io/doc/install/)
2. Clone this repository and symlink it to `~/.config/nvim`

### Tweaks

- I had to enable undercurl in my terminal to avoid strikethrough
  following this guide for the standard terminals:
  [blog](https://dev.to/anurag_pramanik/how-to-enable-undercurl-in-neovim-terminal-and-tmux-setup-guide-2ld7) from [reddit post](https://www.reddit.com/r/neovim/comments/1i11z63/learn_how_to_enable_undercurl_in_neovim_for/)
  or for wezterm see [undercurl FAQ](https://wezterm.org/faq.html#how-do-i-enable-undercurl-curly-underlines)

## Cheat sheet

- [LazyVim Keymaps](https://www.lazyvim.org/keymaps)

## Neogit

Neogit cannot name a stash while it is created, only afterwards
(stash popup -> `m` rename), see
[neogit#1762](https://github.com/NeogitOrg/neogit/issues/1762).

`lua/config/neogit.lua` patches the stash actions, so the message is asked
directly when the stash is created:

- stash popup `z` (worktree + index), `i` (index), `x` (worktree, keep index)
- abort with `Esc`, empty input stashes without a message
- the message is set with `git stash push -m`, so it shows up as
  `On <branch>: <message>` in `git stash list`

Disable it in the plugin spec (`lua/plugins/neogit.lua`):

```lua
  config = function()
    require("config.neogit").setup({ prompt_stash_message = false })
  end,
```

## Tests

```sh
./tests/run.sh
```

Runs the [plenary](https://github.com/nvim-lua/plenary.nvim) tests headless.

