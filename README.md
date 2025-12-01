```
git clone git@github.com:KihongHeo/environment.git
cd environment
./setup.sh
```
## iTerm
- [Color schemes](https://github.com/mbadolato/iTerm2-Color-Schemes)
  * use Argonaut
- [Powerline Font](https://github.com/powerline/fonts/)
  * use Hack
- [Nerd Font](https://www.nerdfonts.com/)
  * MesloLGS NF

## Z Shell
- [Oh My Zsh](https://ohmyz.sh)
- [Syntac highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [Autosuggestion](https://github.com/zsh-users/zsh-autosuggestions)

## Vim
1. Install [vim-plug](https://github.com/junegunn/vim-plug)
2. Launch vim and run `:PlugInstall`
3. Install the following packages for [NeoFormat](https://github.com/sbdchd/neoformat):
- Python: https://github.com/google/yapf
- Ocaml: https://github.com/ocaml-ppx/ocamlformat
- Shell: https://github.com/mvdan/sh
- C/C++: https://clang.llvm.org/docs/ClangFormat.html
- JS/JSON: https://github.com/beautify-web/js-beautify
- Latex: https://github.com/cmhughes/latexindent.pl

4. Coc setup
- node >= 17 ([nvm](https://github.com/nvm-sh/nvm) 이용)
- Launch vim and run `:CocInstall coc-json coc-pyright coc-clangd`
