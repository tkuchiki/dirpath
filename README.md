# dirpath

Dynamically updates your `PATH` environment variable based on `.pathrc` files, inspired by [direnv](https://direnv.net/).

It prioritizes directory-specific PATH settings and is compatible with **bash**, **zsh**, and **fish**.

## Installation

1. Clone or copy the `dirpath` files (e.g., `dirpath.sh`, `dirpath.bash.inc`, `dirpath.zsh.inc`, `dirpath.fish`) to a directory (e.g., `~/dotfiles/dirpath`).
2. Follow the instructions for your shell below to source the appropriate setup file.

---

## 🔧 Shell Setup Instructions

### 🐚 bash

In your `~/.bashrc`:
```bash
source /path/to/dirpath.bash.inc
```

### 💠 zsh

In your `~/.zshrc`:
```zsh
source /path/to/dirpath.zsh.inc
```

### 🐟 fish

In your `~/.config/fish/config.fish`:
```fish
source /path/to/dirpath.fish
```

---

## 🔍 How it works

- When you `cd` into a directory that contains a `.pathrc` file, the listed paths are prepended to your `PATH`.
- If you're inside a git repository, it also checks for a `.pathrc` file at the repo root.
- Directory-local `.pathrc` overrides are prioritized and merged with the repo root `.pathrc`.
- Comments (`#`) and blank lines in `.pathrc` are ignored.

---

## 📄 Example `.pathrc`

```
/opt/homebrew/opt/go@1.22/bin
$HOME/projects/my-bin
```

This will make the listed paths take precedence in your current shell session.
