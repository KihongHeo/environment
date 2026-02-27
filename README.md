# Setup

```bash
git clone git@github.com:KihongHeo/environment.git
cd environment
./setup.sh
```

## Terminal

**iTerm2**
- Color Scheme: [Argonaut](https://github.com/mbadolato/iTerm2-Color-Schemes)
- Font: [Hack Nerd Font](https://www.nerdfonts.com/)

## Shell

- [Oh My Zsh](https://ohmyz.sh)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

## Neovim

1. Launch Neovim once — [lazy.nvim](https://github.com/folke/lazy.nvim) bootstraps automatically
2. Run `:Lazy sync`

### Formatters (NeoFormat)

| Language | Tool |
|----------|------|
| Python | [yapf](https://github.com/google/yapf) |
| OCaml | [ocamlformat](https://github.com/ocaml-ppx/ocamlformat) |
| Shell | [shfmt](https://github.com/mvdan/sh) |
| C/C++ | [clang-format](https://clang.llvm.org/docs/ClangFormat.html) |
| JS/JSON | [js-beautify](https://github.com/beautify-web/js-beautify) |
| LaTeX | [latexindent](https://github.com/cmhughes/latexindent.pl) |

### LSP (Coc)

```bash
# Requires node >= 17 (use nvm)
:CocInstall coc-json coc-pyright coc-clangd
```

### Tree-sitter

```bash
# Install tree-sitter CLI first: https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md
:TSInstall python javascript json cpp ocaml bash latex llvm
```
