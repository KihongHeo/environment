"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => clang-format
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"if has('mac')
"  map <C-K> :py3f /opt/homebrew/Cellar/llvm/12.0.1/share/clang/clang-format.py<cr>
"  imap <C-K> <c-o>:py3f /opt/homebrew/Celler/llvm/12.0.1/share/clang/clang-format.py<cr>
"  function! Formatonsave()
"    let l:formatdiff = 1
"    py3f /opt/homebrew/Celler/llvm/12.0.1/share/clang/clang-format.py
"  endfunction
"else
"  map <C-K> :py3f /usr/share/clang/clang-format-15/clang-format.py<cr>
"  imap <C-K> <c-o>:py3f /usr/share/clang/clang-format-15/clang-format.py<cr>
"  function! Formatonsave()
"    let l:formatdiff = 1
"    py3f /usr/share/clang/clang-format-15/clang-format.py
"  endfunction
"endif
"autocmd BufWritePre *.h,*.cc,*.cpp,*.c call Formatonsave()

" Etc
" https://groups.google.com/g/vim_dev/c/3r7cl8Ys19Q
let g:java_ignore_markdown = 1
