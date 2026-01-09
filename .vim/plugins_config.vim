"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

function! LightlineFilename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%f') !=# '' ? expand('%f') : '[No Name]'
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => neoformat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neoformat_ocaml_ocamlformat = {
            \ 'exe': 'ocamlformat',
            \ 'no_append': 1,
            \ 'stdin': 1,
            \ 'args': ['--enable-outside-detected-project', '--name', '"%:p"', '-']
            \ }

let g:neoformat_enabled_ocaml = ['ocamlformat']

let g:neoformat_tex_latexindent = {
  \ 'exe': 'latexindent',
  \ 'args': ['-l'],
  \ 'stdin': 1
  \ }

let g:neoformat_enabled_python = ['yapf']

let g:neoformat_enabled_cs = ['csharpier']

augroup fmt
  autocmd!
  autocmd BufWritePre *.ml,*.mli,*.sh,*.py,*.json,dune,*.c,*.tex try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => clang-format
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('mac')
  map <C-K> :py3f /opt/homebrew/Cellar/llvm/12.0.1/share/clang/clang-format.py<cr>
  imap <C-K> <c-o>:py3f /opt/homebrew/Celler/llvm/12.0.1/share/clang/clang-format.py<cr>
  function! Formatonsave()
    let l:formatdiff = 1
    py3f /opt/homebrew/Celler/llvm/12.0.1/share/clang/clang-format.py
  endfunction
else
  map <C-K> :py3f /usr/share/clang/clang-format-15/clang-format.py<cr>
  imap <C-K> <c-o>:py3f /usr/share/clang/clang-format-15/clang-format.py<cr>
  function! Formatonsave()
    let l:formatdiff = 1
    py3f /usr/share/clang/clang-format-15/clang-format.py
  endfunction
endif
autocmd BufWritePre *.h,*.cc,*.cpp,*.c call Formatonsave()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Coc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "<S-Tab>"
inoremap <silent><expr> <up> coc#pum#visible() ? coc#pum#prev(0) : "<Up>"
inoremap <silent><expr> <down> coc#pum#visible() ? coc#pum#next(0) : "<Down>"

" Turn on diagnostics always
" autocmd BufWritePost * call timer_start(10, { tid -> execute('execute "CocDiagnostics" | execute "botright lwindow"') })
" autocmd BufWritePost * call timer_start(10, { tid -> execute('execute "CocDiagnostics" | execute "botright lwindow" | execute "wincmd p"') })

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Copilot
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use <C-a> to apply completion.
imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Use <C-p>, <C-n> to cycle through completion options.
imap <C-p> <Plug>(copilot-previous)
imap <C-n> <Plug>(copilot-next)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_error                  = '✘'
let g:ale_sign_warning                = '⚠'
highlight ALEErrorSign ctermbg        =NONE ctermfg=red
highlight ALEWarningSign ctermbg      =NONE ctermfg=yellow

let g:ale_linters = {
\   'ocaml':      ['merlin'],
\   'python':     [],
\   'tex':        ['chktex'],
\}

let g:ale_fixers = {
\   'ocaml':      ['ocamlformat'],
\   '*':          ['remove_trailing_lines', 'trim_whitespace'],
\}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => AutoPairs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is a workaround: when using nvim, Esc-p toggles Autopairs
" conflicting with Esc and paste
let g:AutoPairsShortcutToggle = '<C-p>'

let g:shfmt_opt = "-ci -i 2"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Avante
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd! User avante.nvim
lua << EOF
require('avante').setup({
  provider = "openai-gpt-4o-mini"
})
require("snacks").setup()
EOF

" Etc
" https://groups.google.com/g/vim_dev/c/3r7cl8Ys19Q
let g:java_ignore_markdown = 1
