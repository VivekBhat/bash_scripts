# MBP_Attentive

Attentive MacBook Pro, macOS only (Apple Silicon, Homebrew in /opt/homebrew). Shell: zsh + Oh My Zsh.
The installer, profile and `work/attentive.sh` all refuse or skip on non-macOS systems.

## Install

```bash
bash ~/Projects/private/bash_scripts/Unix/installer.sh   # pick MBP_Attentive
```

The installer:
1. Checks zsh and installs Oh My Zsh if missing.
2. Removes other computers' `profile` lines from `~/.zshrc` (backup in `~/.zshrc.bak`).
3. Appends `source .../MBP_Attentive/profile` to `~/.zshrc`.

## What the profile loads

- `common_scripts/bash_lib/common.sh`, `git_helpers.sh`, `pyvenv_helpers.sh`
- `common_scripts/work/attentive.sh`: `am`, `attn`, `awsp <profile>`, `awsclear`, btr/kubectl aliases
- `~/.attentive_local.sh` if present. Put anything sensitive there, never in this repo.

## Check startup time

```bash
time zsh -i -c exit
```
