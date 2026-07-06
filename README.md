# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

Each directory is a stow package using `--dotfiles` naming (`dot-config` → `.config`, `dot-zshrc` → `.zshrc`, etc.):

| Package | Target |
|---------|--------|
| `dunst` | `~/.config/dunst/` |
| `i3` | `~/.config/i3/` |
| `kitty` | `~/.config/kitty/` |
| `nano` | `~/.nanorc` |
| `nvim` | `~/.config/nvim/` |
| `picom` | `~/.config/picom/` |
| `polybar` | `~/.config/polybar/` |
| `rofi` | `~/.config/rofi/` |
| `tmux` | `~/.tmux.conf` |
| `tmux-plugins` | `~/.config/tmux/plugins/catppuccin/` |
| `zsh` | `~/.zshrc` |

## Usage

```bash
stow --dotfiles -t ~ <package>...
```

Stow all packages:

```bash
stow --dotfiles -t ~ dunst i3 kitty nano nvim picom polybar rofi tmux tmux-plugins zsh
```

## Restore from backup

Backup located at `~/backup-dots/home/piero/`.
